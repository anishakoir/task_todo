<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToDoList.aspx.cs" Inherits="Task_ToDo.ToDoList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
</head>
<body>
	<form id="form1" runat="server">
		<div>
			<table style="width: 80%">
				<tr>
					<td style="font-weight: 700">TODO List Task</td>
				</tr>
				<tr>
					<td>
						<table>
							<tr>

								<td>Task :
									<asp:TextBox ID="txtTask" runat="server"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvTask" runat="server" ControlToValidate="txtTask" ErrorMessage="Please enter Task" ValidationGroup="ValidAddTask" ForeColor="Red"></asp:RequiredFieldValidator>
								</td>
								<td>
									<asp:Button ID="btnAddNewTask" runat="server" Text="Add New Task" ValidationGroup="ValidAddTask" OnClick="btnAddNewTask_Click" />
								</td>
							</tr>

						</table>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;">
						<asp:Button ID="btnShowCompletedTaskOnly" runat="server" Text="Get Completed Tasks Only" OnClick="btnShowCompletedTaskOnly_Click" />
						<asp:Button ID="btnShowAll" runat="server" Text="Show All Tasks" Visible="false" OnClick="btnShowAll_Click" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:GridView ID="gvTodoList" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%"
							AutoGenerateColumns="False" OnRowCommand="gvTodoList_RowCommand" OnRowDataBound="gvTodoList_RowDataBound">
							<AlternatingRowStyle BackColor="White" />
							<Columns>
								<asp:TemplateField HeaderText="S.No" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate><%# Container.DataItemIndex+1 %></ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Task" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
									<ItemTemplate>
										<asp:Label ID="lblTask" runat="server" Text='<%#Eval("Task") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<asp:Button ID="btnMarkAsCompleted" Text="Mark As Completed" CommandArgument='<%#Eval("Id") %>' runat="server" CommandName="MarkAsCompleted" />
										<asp:Button ID="btnRemoveTask" Text="Remove Task" runat="server" CommandArgument='<%#Eval("Id") %>' CommandName="Remove" />
										<asp:HiddenField ID="hdnIsCompleted" runat="server" Value='<%#Eval("IsCompleted") %>' />
									</ItemTemplate>

									<ItemStyle HorizontalAlign="Center"></ItemStyle>
								</asp:TemplateField>
							</Columns>
							<EditRowStyle BackColor="#2461BF" />
							<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
							<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
							<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
							<RowStyle BackColor="#EFF3FB" />
							<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
							<SortedAscendingCellStyle BackColor="#F5F7FB" />
							<SortedAscendingHeaderStyle BackColor="#6D95E1" />
							<SortedDescendingCellStyle BackColor="#E9EBEF" />
							<SortedDescendingHeaderStyle BackColor="#4870BE" />
						</asp:GridView>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>
