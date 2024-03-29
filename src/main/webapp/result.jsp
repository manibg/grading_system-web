
	<div class="row justify-content-center align-items-center" style="height: 20vh; margin: 0;">
		<div class="col-md-6">
				<div style="display:none;" id="errorMsg" class="alert alert-primary alert-dismissible fade show" role="alert">
				  		<i id="messageBody"></i>
				</div>
		</div>
	</div>

	<div class="row justify-content-center align-items-center" style="height: 20vh; margin: 0;">
		<div>
			<h3>Check a Student Result</h3>
			<br>
			<form onsubmit="getResult()">
				Enter the Register Number : <input type="number" id="regno" min="1001"
					max="1020" required autofocus /><br> <br> <input
					type="submit" class="btn btn-primary" value="Enter" /> <input
					type="reset" class="btn btn-primary"> <br> <br> <br>
		
				<div id="cbody"></div>
			</form>
		</div>
	</div>
<script>
function getResult() {

	event.preventDefault();
	// step 1: Get form values
	let regNo = document.getElementById("regno").value;

	//send ajax request
	let formData = "regno="+regNo;
	//var url = server + "/gradingsystem-api/StudentResultServlet?"+formData;
	var url =server + "/studentResult?"+formData;

	document.getElementById("cbody").innerHTML="";
	
	var resultPromise = $.ajax(url, "GET", formData);
	
	resultPromise.then(function (response) {

		var student = response.studentGrade;
		var list = response.marks;
		//var student = response.SD;

		console.log(student);
		console.log(list);
		
			document.querySelector("#messageBody").innerHTML = "<font color='green'><b>" + student.studentName + " Result</b></font>";
			$('#errorMsg').css({'display':'block'});
			
	        //document.getElementById("studlist").innerHTML = "";
	        cont = "<h4>Result:</h4><br/><h5>Student Name : "+student.studentName+"</h5><h5>Register Number : "+student.regNo+"</h5><br>";
	
	        for (let marks of list) {
	            cont += "<h5>"+marks.subject.code+" : "+marks.mark+"</h5>";
	        }
	
	        cont += "<br><h5>OverAll Percentage : "+student.avg+"</h5><h5>Grade : "+student.grade+"</h5>";
	
	        var list = document.getElementById("cbody");
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
