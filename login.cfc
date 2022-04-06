<cfcomponent>
   <cffunction name="createUser" access="public" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_fullName = form.fld_fullName/>	
		<cfset variables.fld_userEmail = form.fld_userEmail/>
		<cfset variables.fld_userName = form.fld_userName/>
		<cfset variables.fld_userPwd = form.fld_userPwd/>
		<cfset variables.fld_userCnfPwd = form.fld_userCnfPwd/>		
		<cfif variables.fld_fullName EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter FullName')>
		</cfif>
		<cfif variables.fld_userEmail EQ '' OR NOT isValid("eMail", variables.fld_userEmail)>
			<cfset arrayAppend(errorMessage, 'Please Enter valid Email')>
		</cfif>
		<cfif variables.fld_userName EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter UserName')>
		</cfif>
		<cfif variables.fld_userPwd EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Password')>
		</cfif>
		<cfif variables.fld_userCnfPwd EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Confirm Password')>
		</cfif>
		<cfif  variables.fld_userCnfPwd NOT EQUAL '' AND variables.fld_userPwd NOT EQUAL variables.fld_userCnfPwd>
			<cfset arrayAppend(errorMessage, 'Confirm Password Mismatch')>
		</cfif>
		<cfquery name="local.checkUsername">
			SELECT username FROM users WHERE username = <cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfif local.checkUsername.recordcount EQ 1>
			<cfset arrayAppend(errorMessage, 'Username Already exists')>
		</cfif>
		<cfquery name="local.checkEmail">
			SELECT email_id FROM users WHERE email_id = <cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfif local.checkEmail.recordcount EQ 1>
			<cfset arrayAppend(errorMessage, 'Email Already exists')>
		</cfif>
		<cfif arrayIsEmpty(errorMessage)>
			<cfquery>INSERT INTO users (fullname,email_id,username, pwd)
				VALUES (
					<cfqueryparam value="#variables.fld_fullName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#variables.fld_userEmail#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#hash(variables.fld_userPwd,'SHA')#" cfsqltype="cf_sql_varchar" />					
					)
			</cfquery>			
		</cfif>
		<cfreturn variables.errorMessage />						
	</cffunction>
	
   <cffunction name="getLoginQuery" access="remote" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.fld_userName = form.fld_userName/>
		<cfset variables.fld_userPwd = form.fld_userPwd/>
		<cfif variables.fld_userName EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter UserName')>
		</cfif>
		<cfif variables.fld_userPwd EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Password')>
		</cfif>
		<cfif arrayIsEmpty(errorMessage)>
			<cfquery name="local.checkLogin">
				SELECT * FROM users 
					WHERE username = <cfqueryparam value="#variables.fld_userName#" cfsqltype="cf_sql_varchar" /> AND pwd = <cfqueryparam value="#hash(variables.fld_userPwd,'SHA')#" cfsqltype="cf_sql_varchar" />
			</cfquery>
			<cfif local.checkLogin.recordcount EQ 1>
				<cfset session.stLoggedInUser = {'userFullName' = local.checkLogin.fullname, 'userID' = local.checkLogin.userid} > 
			<cfelse>
				<cfset arrayAppend(errorMessage, 'Invalid User Login')>
			</cfif>
		</cfif>
		<cfreturn variables.errorMessage />
	</cffunction>

	<cffunction name="createContact" access="public" output="false">
		<cfset variables.errorMessage= arrayNew(1) />
		<cfset variables.cont_title = form.cont_title/>
		<cfset variables.cont_firstname = form.cont_firstname/>	
		<cfset variables.cont_lastname = form.cont_lastname/>
		<cfset variables.cont_gender = form.cont_gender/>	
		<cfset variables.cont_dob = form.cont_dob/>
		<cfset variables.cont_photo = form.cont_photo/>
		<cfset variables.cont_image = form.cont_image/>
		<cfset variables.cont_addr = form.cont_addr/>
		<cfset variables.cont_street = form.cont_street/>
		<cfset variables.cont_pin = form.cont_pin/>
		<cfset variables.cont_email = form.cont_email/>
		<cfset variables.cont_phone = form.cont_phone/>		
		<cfset variables.cont_id = form.cont_id/>
		<cfif variables.cont_title EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Title')>
		</cfif>		
		<cfif variables.cont_firstname EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter FirstName')>
		</cfif>
		<cfif variables.cont_lastname EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter LastName')>
		</cfif>
		<cfif variables.cont_gender EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Gender')>
		</cfif>
		<cfif variables.cont_dob EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Date of Birth')>
		</cfif>
		<cfif variables.cont_addr EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Address')>
		</cfif>
		<cfif variables.cont_street EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Street')>
		</cfif>
		<cfif variables.cont_pin EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Pin')>
		</cfif>
		<cfif variables.cont_email EQ '' OR NOT isValid("eMail", variables.cont_email)>
			<cfset arrayAppend(errorMessage, 'Please Enter valid Email')>
		</cfif>		
		<cfif variables.cont_phone EQ ''>
			<cfset arrayAppend(errorMessage, 'Please Enter Phone')>
		</cfif>
		<cfset variables.cont_imge = variables.cont_image>
		<cfif structKeyExists(form,"cont_photo") and len(trim(form.cont_photo))>
			<cfset variables.thisDir = expandPath(".")>
			<cffile action="upload" fileField="form.cont_photo" destination="#variables.thisDir#/img/contact-img" result="fileUpload" nameconflict="overwrite">
			<cfset variables.cont_imge = fileUpload.serverFile>
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.cont_id EQ ''>
			<cfquery>
				INSERT INTO contact (user_id,title,firstname,lastname,gender,dateof_birth,contact_image,address,street,pincode,contact_email,contact_phone)
				VALUES (
						<cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_varchar" />,	
						<cfqueryparam value="#variables.cont_title#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_firstname#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_lastname#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_gender#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_dob#" cfsqltype="CF_SQL_DATE" />,
						<cfqueryparam value="#variables.cont_imge#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_addr#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_street#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_pin#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_email#" cfsqltype="cf_sql_varchar" />,
						<cfqueryparam value="#variables.cont_phone#" cfsqltype="cf_sql_varchar" />					
					)
			</cfquery>			
		</cfif>
		<cfif arrayIsEmpty(errorMessage) AND variables.cont_id NEQ ''>
			<cfquery>
				UPDATE contact SET 			
				title = <cfqueryparam value="#variables.cont_title#" cfsqltype="cf_sql_varchar" />,
				firstname = <cfqueryparam value="#variables.cont_firstname#" cfsqltype="cf_sql_varchar" />,
				lastname = <cfqueryparam value="#variables.cont_lastname#" cfsqltype="cf_sql_varchar" />,
				gender = <cfqueryparam value="#variables.cont_gender#" cfsqltype="cf_sql_varchar" />,
				dateof_birth = <cfqueryparam value="#variables.cont_dob#" cfsqltype="CF_SQL_DATE" />,
				contact_image = <cfqueryparam value="#variables.cont_imge#" cfsqltype="cf_sql_varchar" />,
				address = <cfqueryparam value="#variables.cont_addr#" cfsqltype="cf_sql_varchar" />,
				street = <cfqueryparam value="#variables.cont_street#" cfsqltype="cf_sql_varchar" />,
				pincode = <cfqueryparam value="#variables.cont_pin#" cfsqltype="cf_sql_varchar" />,
				contact_email = <cfqueryparam value="#variables.cont_email#" cfsqltype="cf_sql_varchar" />,
				contact_phone  = <cfqueryparam value="#variables.cont_phone#" cfsqltype="cf_sql_varchar" /> WHERE contact_id = #variables.cont_id#	AND user_id = #session.stLoggedInUser.userID#			
			</cfquery>			
		</cfif>
		<cfreturn variables.errorMessage />						
	</cffunction>

	<cffunction name="deleteContact" returntype="void" >			
			<cfquery>
				DELETE FROM contact WHERE contact_id = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer" /> AND user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
			</cfquery>
	</cffunction>

	 <cffunction name="getContacts" access="public" output="false" returntype="query">		
		<cfquery name="local.rs_getContacts">
			SELECT * FROM contact WHERE user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" /> ORDER BY contact_id
		</cfquery>
		<cfreturn local.rs_getContacts />
	</cffunction>

	<cffunction name="getContactsExcel" access="public" output="false" returntype="query">		
		<cfquery name="local.rs_getContacts">
			SELECT firstname,contact_email,contact_phone,address,street,pincode FROM contact WHERE user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" /> ORDER BY contact_id
		</cfquery>
		<cfreturn local.rs_getContacts />
	</cffunction>

	<cffunction name="getContactById" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="contact_id" required="yes">		
		<cfquery name="local.rs_getContactById">
			SELECT * FROM contact  WHERE contact_id = <cfqueryparam value="#arguments.contact_id#" cfsqltype="cf_sql_integer" /> AND user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn serializeJSON(local.rs_getContactById,"struct") />
	</cffunction>

	<cffunction name="getContactBy" access="remote" output="false" returntype="any" returnformat="JSON">
		<cfargument name="contact_id" required="yes">		
		<cfquery name="local.rs_getContactBy">
			SELECT * FROM contact  WHERE contact_id = <cfqueryparam value="#arguments.contact_id#" cfsqltype="cf_sql_integer" /> AND user_id = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn serializeJSON(local.rs_getContactBy,"struct") />
	</cffunction>	

	<cffunction name="updateUserImage" access="remote" output="false" >	
		<cfset variables.thisDir = expandPath(".")>
		<cffile action="upload" filefield="form.upload" destination="#variables.thisDir#/img/profile-img" nameconflict="makeunique" result="uploadResult">	
		<cfif uploadResult.fileWasSaved>
			<cfset variables.user_imge = uploadResult.serverFile>
			<cfquery>
				UPDATE users SET image_name = <cfqueryparam value="#variables.user_imge#" cfsqltype="cf_sql_varchar" /> WHERE userid = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cfif>					
	</cffunction>

	<cffunction name="getUserImage" access="public" output="false" returntype="query">		
		<cfquery name="local.rs_getUserImage">
			SELECT image_name FROM users  WHERE userid = <cfqueryparam value="#session.stLoggedInUser.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>		
		<cfreturn local.rs_getUserImage />
	</cffunction>

	<cffunction name="getOrmContacts" access="public" returnType="any" output="true">              
          <cfset variables.getcontacts = EntityLoad('Contact',{user_id=session.stLoggedInUser.userID},'contact_id desc')>
          <cfreturn variables.getcontacts>    
     </cffunction>		 
</cfcomponent>

