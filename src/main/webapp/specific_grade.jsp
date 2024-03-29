
	
	<div class="row justify-content-center align-items-center" style="height: 20vh; margin: 0;">
		<div class="col-md-6">
				<div style="display:none;" id="errorMsg" class="alert alert-primary alert-dismissible fade show" role="alert" >
				  		<i id="messageBody" style="text-align:center;"></i>
				</div>
		</div>
	</div>

	<div class="row justify-content-center align-items-center" style="height: 20vh; margin: 0;">
		<div>
			<h3>List of Student on a Specific Grade</h3>
			<br>
			<form onsubmit="listStudent()" >
				Enter a Specific Grade : <input type="text" autocomplete="off" id="grade" class="form-control" pattern="[A-Za-z]{1}$" title="Enter only one alphabets letter" 
				required autofocus /><br><br> 
				<div class="text-center">
					<input type="submit" class="btn btn-primary" value="Enter" />
					<input type="reset" class="btn btn-primary"> <br><br>
				</div>
			</form><br><br/><br>
		</div>
	</div>
	<div class="row justify-content-center align-items-center" style="height: 60vh; margin: 0;">
		<div>
			<div id="tbody"></div>
		</div>
	</div>
<script>
function listStudent() {

	event.preventDefault();
	// Get form values
	let grade = document.getElementById("grade").value;

	let formData = "grade="+grade;
	//var url = server + "/gradingsystem-api/StudentByGradeServlet?"+formData;
	var url = server + "/grade/SpecficGradeWiseList?"+formData;

	document.getElementById("tbody").innerHTML="";

	var listPromise = $.ajax(url, "GET", formData);

	listPromise.then(function (response) {

		console.log(response);

			document.querySelector("#messageBody").innerHTML = "<font color='green'><b>Grade: "+grade+"</b> wise List</font>";
			$('#errorMsg').css({'display':'block'});
			
	        var list = response;
	        cont = "<h3>List Of Students :</h3><table class='table'><thead><tr><th>S.No</th><th>Student Name</th><th>Register Number</th><th>Percentage ( % )</th><th>Grade</th></tr></thead><tbody>";
	
	        for (let stud of list) {
	            cont += "<tr><td></td><td>";
	            cont += stud.studentName;
	            cont += "</td><td>";
	            cont += stud.regNo;
	            cont += "</td><td>";
	            cont += stud.avg;
	            cont += "</td><td>";
	            cont += stud.grade;
	            cont += "</td></tr>";
	        }
	
	        cont += "</tbody></table>";
	
	        var list = document.getElementById("tbody");
	        list.innerHTML = cont;
		
    },
	function(response) {
		console.log("error");	
		console.log(response);
		
		var msg = response.responseJSON.errorMessage;
		console.log(msg);
			document.querySelector("#messageBody").innerHTML = "<font color='red'>" + msg + "</font>";
			$('#errorMsg').css({'display':'block'});
		
	});
}

</script>
