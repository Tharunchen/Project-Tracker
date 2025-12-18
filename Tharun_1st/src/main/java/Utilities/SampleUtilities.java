package Utilities;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.RolesDetails;
import Model.SampleModel;
import tharun.DatabaseOperations;
import tharun.ISTDate;

public class SampleUtilities extends Message {

    private String message = "";

    // INSERT
    public String insertdetails(SampleModel model) {

        try {
            String selectQuery =
                "select * from registerdetails where username='"
                + model.getUsername() + "' and deleteflag=0";

            ResultSet res = DatabaseOperations.select(selectQuery);

            if (res.next()) {
                message = DATA_EXISTS;
            } else {

                String createdBy = "Tharun R";

                String insertQuery =
                    "INSERT INTO registerdetails (name, address, username, password, createdby, createddate) VALUES ('"
                    + model.getName() + "','"
                    + model.getAddress() + "','"
                    + model.getUsername() + "','"
                    + model.getPassword() + "','"
                    + createdBy + "','"
                    + ISTDate.getISTDateTime() + "')";

                int result = DatabaseOperations.insertAndGetId(insertQuery);
                
                String insertQuery1 =
                        "INSERT INTO role_assigned (username) VALUES ('"+model.getUsername()+"')";
                    int result1 = DatabaseOperations.insertAndGetId(insertQuery1);

                if (result > 0) {
                    message = INSERT_MESSAGE;
                } else {
                    message = SOMETHING_WENT_WRONG;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            message = SOMETHING_WENT_WRONG;
        }

        return message;
    }


    // FETCH ALL
    public List<SampleModel> getAllDetails() {

        List<SampleModel> list = new ArrayList<>();

        try {
        	String Query="SELECT * FROM registerdetails";
            ResultSet res = DatabaseOperations.select(Query);

            while (res.next()) {
                SampleModel model = new SampleModel();
                model.setSlno(res.getInt("slno"));
                model.setName(res.getString("name"));
                model.setAddress(res.getString("address"));
                model.setUsername(res.getString("username"));
                model.setPassword(res.getString("password"));
                list.add(model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // UPDATE
    public String updateSkill(SampleModel model) {

        String updateQuery =
            "UPDATE registerdetails SET "
            + "name='" + model.getName() + "', "
            + "address='" + model.getAddress() + "', "
            + "username='" + model.getUsername() + "' "
            + "password='" + model.getPassword() + "' "
            + "WHERE slno='" + model.getSlno() + "'";

        int result = DatabaseOperations.update(updateQuery);
        message = (result > 0) ? UPDATE_MESSAGE : SOMETHING_WENT_WRONG;

        return message;
    }
    
    public List<RolesDetails> getdropdown() {

        List<RolesDetails> list = new ArrayList<>();

        try {
			/*
			 * String Query="SELECT * FROM roles_details rd " +
			 * "left join role_assigned ra on ra.role_assigned_id=rd.slno " +
			 * "where rd.slno=ra.role_assigned_id";
			 */
        	String Query="SELECT * FROM roles_details";
        	
            ResultSet res = DatabaseOperations.select(Query);

            while (res.next()) {
            	RolesDetails model = new RolesDetails();
                model.setSlno(res.getInt("slno"));
                model.setRolename(res.getString("rolename"));
                list.add(model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<RolesDetails> getdropdownusername() {

        List<RolesDetails> list = new ArrayList<>();

        try {
            ResultSet res = DatabaseOperations.select("SELECT username FROM role_assigned group by username");

            while (res.next()) {
            	RolesDetails model = new RolesDetails();
            	 //COUNT(slno) AS total_roles
                //model.setSlno(res.getInt("slno"));
                model.setUsername(res.getString("username"));
                list.add(model);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
}
