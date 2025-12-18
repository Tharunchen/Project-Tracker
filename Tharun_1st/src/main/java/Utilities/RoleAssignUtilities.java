package Utilities;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.RoleAsingModel;
import Model.RolesDetails;
import Model.SampleModel;
import tharun.DatabaseOperations;
import tharun.ISTDate;

public class RoleAssignUtilities  extends Message {

    private String message = "";
    
    public String insertroledetails(RoleAsingModel RoleAsingModels) {

        try {
        	String duplicateCheckQuery =
        		    "SELECT COUNT(*) AS total FROM role_assigned " +
        		    "WHERE username = '" + RoleAsingModels.getUsername() + "' " +
        		    "AND role_assigned_id = '" + RoleAsingModels.getRoleid() + "' " +
        		    "AND deleteflag = 0";


        	        ResultSet rsDuplicate = DatabaseOperations.select(duplicateCheckQuery);

        	        if (rsDuplicate.next() && rsDuplicate.getInt("total") > 0) {
        	            message = DATA_EXISTS;   
        	            return message;
        	        } else {
                	 
                String createdBy = "Tharun R";
                String insertQuery ="INSERT INTO role_assigned (username, role_assigned_id) VALUES "
                    + "('"+RoleAsingModels.getUsername() + "','"+ RoleAsingModels.getRoleid()+"')";
                   
                int result = DatabaseOperations.insertAndGetId(insertQuery);
             
                if (result > 0) {
                    message = INSERT_MESSAGE;
                } else {
                    message = SOMETHING_WENT_WRONG;
                }
                 }
            
        } catch (Exception e) {
            e.printStackTrace();
            message = SOMETHING_WENT_WRONG;
        }

        return message;
    }


    // FETCH ALL
    public List<RoleAsingModel> getAllRoleDetails() {

        List<RoleAsingModel> list = new ArrayList<>();

        try {
        	String Query="SELECT ra.slno,ra.username,rd.rolename FROM roles_details rd "
        			+ "left join role_assigned ra on ra.role_assigned_id=rd.slno "
        			+ "where rd.slno=ra.role_assigned_id and ra.deleteflag=0";
        	
            ResultSet res = DatabaseOperations.select(Query);

            while (res.next()) {
            	RoleAsingModel model = new RoleAsingModel();
                model.setSlno(res.getInt("slno"));
                model.setUsername(res.getString("username"));
                model.setRolename(res.getString("rolename"));
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
    
    public RoleAsingModel getIndividualroleDetails(int slno) {

        RoleAsingModel model = new RoleAsingModel();

        ResultSet res = null;

        try {
            String query =
                "SELECT ra.slno,ra.username,rd.rolename FROM roles_details rd " +
                "LEFT JOIN role_assigned ra ON ra.role_assigned_id = rd.slno " +
                "WHERE ra.slno = '" + slno + "' and ra.deleteflag=0";

            res = DatabaseOperations.select(query);

            if (res.next()) {
                model.setSlno(res.getInt("slno"));
                model.setUsername(res.getString("username"));
                model.setRolename(res.getString("rolename"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseOperations.closeConnection();
        }

        return model;
    }
    
    public String deleteentry(int slno) {

        String updateQuery =
            "UPDATE role_assigned SET deleteflag=1 where slno='"+slno+"'";

        int result = DatabaseOperations.update(updateQuery);
        message = (result > 0) ? UPDATE_MESSAGE : SOMETHING_WENT_WRONG;

        return message;
    }


}
