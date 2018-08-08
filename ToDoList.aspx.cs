using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task_ToDo
{
	public partial class ToDoList : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				FillTaskListGrid();
			}
		}

		private void FillTaskListGrid(bool IsCompletedOnly=false)
		{
			string strQuery = "SELECT[ID],[Task],[IsCompleted],[IsRemoved],[CreatedOn] FROM Tbl_TaskTODO WHERE IsREmoved = No ";
			if (IsCompletedOnly)
			{
				strQuery += " and IsCompleted=Yes";
			}
			strQuery += ";";
			OleDbConnection con = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
			OleDbCommand cmd = new OleDbCommand(strQuery, con);
			OleDbDataAdapter da = new OleDbDataAdapter(cmd);
			DataSet ds = new DataSet();
			da.Fill(ds);
			gvTodoList.DataSource = ds;
			gvTodoList.DataBind();
		}

		private void MarkAsCompleted(int id)
		{
			OleDbConnection con = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
			OleDbCommand cmd = new OleDbCommand(@" Update Tbl_TaskTODO set [IsCompleted]=Yes WHERE Id = " + id.ToString() + ";", con);
			con.Open();
			cmd.ExecuteNonQuery();
			con.Close();
		}

		private void RemoveTask(int id)
		{
			OleDbConnection con = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
			OleDbCommand cmd = new OleDbCommand(@" Update Tbl_TaskTODO set [IsRemoved]=Yes WHERE Id = " + id.ToString() + ";", con);
			con.Open();
			cmd.ExecuteNonQuery();
			con.Close();
		}

		protected void gvTodoList_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			if (e.CommandName == "MarkAsCompleted")
			{
				MarkAsCompleted(Convert.ToInt32(e.CommandArgument));
				FillTaskListGrid();
			}
			else if (e.CommandName == "Remove")
			{
				RemoveTask(Convert.ToInt32(e.CommandArgument));
				FillTaskListGrid();
			}
		}

		protected void gvTodoList_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			try
			{
				bool isCOmpleted = Convert.ToBoolean((e.Row.FindControl("hdnIsCompleted") as HiddenField).Value);
				if (isCOmpleted)
				{
					(e.Row.FindControl("lblTask") as Label).Font.Strikeout = true;
				}
			}
			catch (Exception ex)
			{

			}
		}

		protected void btnAddNewTask_Click(object sender, EventArgs e)
		{
			OleDbConnection con = new OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
			OleDbCommand cmd = new OleDbCommand(@"Insert into Tbl_TaskTODO (Task) Values('" + txtTask.Text + "');", con);
			con.Open();
			cmd.ExecuteNonQuery();
			con.Close();
			txtTask.Text = string.Empty;
			FillTaskListGrid();
		}

		protected void btnShowCompletedTaskOnly_Click(object sender, EventArgs e)
		{
			FillTaskListGrid(true);
			btnShowAll.Visible = true;
			btnShowCompletedTaskOnly.Visible = false;
		}

		protected void btnShowAll_Click(object sender, EventArgs e)
		{
			FillTaskListGrid();
			btnShowAll.Visible = false;
			btnShowCompletedTaskOnly.Visible = true;
		}
	}
}