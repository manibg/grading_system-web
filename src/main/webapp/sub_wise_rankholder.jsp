	
	<div class="row justify-content-center align-items-center" style="height: 20vh; margin: 0;">
		<div class="col-md-6">
				<div style="display:none;" id="errorMsg" class="alert alert-primary alert-dismissible fade show" role="alert" >
				  		<i id="messageBody" style="text-align:center;"></i>
				</div>
		</div>
	</div>

	<div class="row justify-content-center align-items-center" style="height: 30vh; margin: 0;">
		<div>
			<h3>Subject wise RankHolder</h3><br>
			<form onsubmit="rankHolder()">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-prepend">
										<label for="" class="text-center text-light bg-info form-control">Select a subject</label>
									</div>
									<select id="subCode" class="form-control">
										<option value="ENG11">ENGLISH</option>
										<option value="MAT12">MATHS</option>
										<option value="PHY13">PHYSICS</option>
										<option value="CHE14">CHEMISTRY</option>
										<option value="COM15">COMPUTER</option>
									</select><br><br> 
								</div>
							</div>
				 
				<div class="text-center">
					<button class="btn btn-primary" >Enter </button>
					<button class="btn btn-secondary" onClick="window.location='?pageName=userHome.jsp';">Back </button> <br><br>
				</div>
			</form><br><br/><br><br>
		</div>
	</div>
	
	<div class="row justify-content-center align-items-center" style="height: 80vh; margin: 09vh;">
		<div>
			<div id="tbody"></div>
		</div>
	</div>
<script>
function rankHolder() {

	event.preventDefault();
	
	let subName = document.getElementById("subCode").value;
	let formData = "subjectCode="+subName;
	var url = server + "/subjectWise?"+formData;

	document.getElementById("tbody").innerHTML="";
	
	var listPromise = $.ajax(url, "GET", formData);
	
	listPromise.then(function (response) {

		var msg = response.errMessage;
		console.log(msg);

		if(msg != undefined){
			document.querySelector("#messageBody").innerHTML = "<font color='red'>"+msg+"</font>";
			$('#errorMsg').css({'display':'block'});
		}else{
			document.querySelector("#messageBody").innerHTML = "<font color='green'><b>Subject code: "+subName+" </b> wise mark List</font>";
			$('#errorMsg').css({'display':'block'});
			
	        var list = response;
	        cont = "<h3>Subject wise RankHolders : ( "+subName+" )</h3><table class='table'><thead><tr><th>S.No</th><th>Student Name</th><th>Register Number</th><th>Mark</th></tr></thead><tbody>";
	
	        for (let stud of list) {
	            cont += "<tr><td></td><td>";
	            cont += stud.studentDetail.studentName;
	            cont += "</td><td>";
	            cont += stud.studentDetail.regNo;
	            cont += "</td><td>";
	            cont += stud.mark;
	            cont += "</td></tr>";
	        }
	
	        cont += "</tbody></table>";
	
	        var list = document.getElementById("tbody");
	        list.innerHTML = cont;
		}
    });
}

</script>
