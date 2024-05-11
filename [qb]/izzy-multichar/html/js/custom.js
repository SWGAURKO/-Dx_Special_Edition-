let sex = "male";
let selectedPlayer = null;
let framework = null;

function errorNotify(text) {
  $("#errorBoxClass").css("opacity", "0");
  $("#errorBoxClass").removeClass("hidden");
  $("#errorBoxText").html(text);
  $("#errorBoxClass").animate(
    {
      opacity: 1,
    },
    200
  );

  setTimeout(function () {
    $("#errorBoxClass").animate(
      {
        opacity: 0,
      },
      200
    );
    setTimeout(function () {
      $("#errorBoxClass").addClass("hidden");
    }, 200);
  }, 2000);

  $("#errorBoxClass").off("click");
  $("#errorBoxClass").on("click", function () {
    $("#errorBoxClass").animate(
      {
        opacity: 0,
      },
      200
    );
    setTimeout(function () {
      $("#errorBoxClass").addClass("hidden");
    }, 200);
  });
}

function openCreateMenu() {
  $.post(
    "http://izzy-multichar/selectGender",
    JSON.stringify({ gender: "male" })
  );
  $("#doneBtnText").text("CREATE CHARACTER");

  $("#selectedChar").addClass("hidden");
  setTimeout(function () {
    $("#selectedChar").addClass("opacity-0");
  }, 150);

  $("#createMenu").removeClass("hidden");
  setTimeout(function () {
    $("#createMenu").removeClass("opacity-0");
  }, 150);

  $("#doneBtn").off("click");
  $("#doneBtn").on("click", function () {
    var sex = $("#maleBtn").hasClass("maleBtnActive") ? 0 : 1;
    var firstname = $("#charCreateFirstname").val();
    var lastname = $("#charCreateLastname").val();

    var day = $("#charCreateDay").val();
    var month = $("#charCreateMonth").val();
    var year = $("#charCreateYear").val();

    var DateOfBirth = year + "-" + month + "-" + day;

    if (framework == "qb") {
      var nationality = $("#charCreateNationality").val();
    }

    if (firstname.length < 2 || lastname.length < 2) {
      errorNotify("You must enter a valid name!");
      return;
    }

    if (day.length < 2) {
      day = "0" + day;
    }

    if (month.length < 2) {
      month = "0" + month;
    }

    if (framework == "qb") {
      if (nationality.length < 2) {
        errorNotify("Enter a valid nationality!");
        return;
      }
    }

    if (framework == "qb") {
      let payload = {
        gender: sex,
        firstname: firstname,
        lastname: lastname,
        birthdate: DateOfBirth,
        nationality: nationality,
      };

      $.post("http://izzy-multichar/createChar", JSON.stringify(payload));
      $("body").addClass("hidden");
    } else {
      DateOfBirth = DateOfBirth.split("-");
      DateOfBirth =
        DateOfBirth[2] + "/" + DateOfBirth[1] + "/" + DateOfBirth[0];

      if (sex == 0){
        sex = "m"
      }else{
        sex = "f"
      }
      let payload = {
        gender: sex,
        firstname: firstname,
        lastname: lastname,
        dateofbirth: DateOfBirth,
        height: 180,
      };

      $.post("http://izzy-multichar/createChar", JSON.stringify(payload));
      $("body").addClass("hidden");
    }
  });
}

function openSelectMenu(charId) {
  selectedPlayer = charId;
  $("#doneBtnText").text("PLAY GAME");

  $("#createMenu").addClass("hidden");
  setTimeout(function () {
    $("#createMenu").addClass("opacity-0");
  }, 150);

  $("#selectedChar").removeClass("hidden");
  setTimeout(function () {
    $("#selectedChar").removeClass("opacity-0");
  }, 150);

  $.post(
    "http://izzy-multichar/selectChar",
    JSON.stringify({ identifier: charId }),
    function (data) {
      $("#loadedCharFirstname").text(data.firstname);
      $("#loadedCharLastname").text(data.lastname);
      $("#loadedCharJob").text(data.job);
      $("#loadedCharCash").text("$" + data.cash);
      $("#loadedCharBank").text("$" + data.bank);
      if (framework == "qb") {
        $("#loadedCharNationality").text(data.nationality);
      } else {
        $("#nationalitySelect").hide();
      }

      const DateOfBirth = data.dateofbirth.split("-");
      $("#loadedCharDay").val(DateOfBirth[2]);
      $("#loadedCharMonth").val(DateOfBirth[1]);
      $("#loadedCharYear").val(DateOfBirth[0]);
    }
  );

  $("#doneBtn").off("click");
  $("#doneBtn").on("click", function () {
    if (selectedPlayer != null)
      $.post(
        "http://izzy-multichar/playChar",
        JSON.stringify({ identifier: selectedPlayer }),
        function (data) {
          if (data == false) {
            errorNotify("You must select a character!");
          } else {
            $("body").addClass("hidden");
          }
        }
      );
  });
}

function openKeycodeMenu() {
  $("#keycodeMenu").removeClass("hidden");
  setTimeout(function () {
    $("#keycodeMenu").removeClass("opacity-0");
  }, 150);
}

function closeKeycodeMenu() {
  $("#keycodeMenu").addClass("opacity-0");
  setTimeout(function () {
    $("#keycodeMenu").addClass("hidden");
  }, 150);
}

function loadChars(data, maxValue, defaultSlots, maxSlots) {
  $("#charList").html("");
  console.log("loading char list", JSON.stringify(data))
  for (var i = 0; i < data.length; i++) {
    var charObject = data[i];

    var currentYear = new Date().getFullYear();

    if(charObject.dateofbirth) {
      charYear = charObject.dateofbirth.split("-")

      if(charYear) {
        charAge = currentYear - charYear[0];
      }
      else {
        charAge = charObject.dateofbirth
      }
    }
    else {
      charAge = "Not Found"
    }


    var charHtml = `
		<div data-charid="${charObject.identifierChar
      }" class="selectCharacterBtn cursor-pointer opacity-50 hover:opacity-100 transition-all charItem rounded-md flex items-center relative py-2 px-3">
			<div class="relative flex items-center gap-3 w-full">
				<div class="absolute w-0.5 h-10 bg-white -left-3 rounded-lg top-0 bottom-0 my-auto">

				</div>
				<div class="w-16 h-16 bg-white bg-opacity-[8%] flex items-center justify-center rounded-lg">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M23.3333 0.666748V9.16675H20.5V5.51883L14.8687 11.1147C15.3173 11.7758 15.6597 12.4784 15.8958 13.2227C16.1319 13.9669 16.25 14.7399 16.25 15.5417C16.25 17.714 15.4944 19.5556 13.9833 21.0667C12.4722 22.5779 10.6305 23.3334 8.45829 23.3334C6.28607 23.3334 4.4444 22.5779 2.93329 21.0667C1.42218 19.5556 0.666626 17.714 0.666626 15.5417C0.666626 13.3695 1.42218 11.5279 2.93329 10.0167C4.4444 8.50564 6.28607 7.75008 8.45829 7.75008C9.23746 7.75008 10.0048 7.862 10.7604 8.08583C11.5159 8.30967 12.2125 8.65817 12.85 9.13133L18.4812 3.50008H14.8333V0.666748H23.3333ZM8.45829 10.5834C7.08885 10.5834 5.9201 11.0674 4.95204 12.0355C3.98399 13.0036 3.49996 14.1723 3.49996 15.5417C3.49996 16.9112 3.98399 18.0799 4.95204 19.048C5.9201 20.0161 7.08885 20.5001 8.45829 20.5001C9.82774 20.5001 10.9965 20.0161 11.9645 19.048C12.9326 18.0799 13.4166 16.9112 13.4166 15.5417C13.4166 14.1723 12.9326 13.0036 11.9645 12.0355C10.9965 11.0674 9.82774 10.5834 8.45829 10.5834Z" fill="white"/>
					</svg>
				</div>
				<div class="flex items-center justify-between gap-3">
					<div class="flex flex-col">
						<div class="fontBarlow text-white text-xl font-semibold leading-5">${charObject.name
      } ${charObject.surname}</div>
						<div class="fontBarlow font-medium  ${charObject.gender ? "text-[#FC79FF]" : "text-[#79C7FF]"
      } leading-5">${charObject.gender ? "Female" : "Male"}</div>
					</div>
					<div class="w-8 h-8 bg-white flex items-center justify-center bg-opacity-[15%] rounded-md">
						${charAge}
					</div>
				</div>
				<svg class="absolute right-0" width="10" height="18" viewBox="0 0 10 18" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M1.75 15.875L8.625 9L1.75 2.125" stroke="white" stroke-width="2.75" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
			</div>
		</div>
		`;

    $("#charList").append(charHtml);
  }

  var maxCharLenght = maxValue + defaultSlots + 1;

  if (maxCharLenght > data.length) {
    var count = maxCharLenght - data.length;
    for (var i = 0; i < count; i++) {
      var createHtml = `
			<div class="createCharacterBtn cursor-pointer opacity-60 hover:opacity-100 transition-all charNewItem rounded-md flex items-center relative py-2 px-3">
				<div class="relative flex items-center gap-3 w-full">
					<div class="absolute w-0.5 h-10 bg-[#B6FFD3] -left-3 rounded-lg top-0 bottom-0 my-auto">
		
					</div>
					<div class="w-16 h-16 bg-white bg-opacity-[8%] flex items-center justify-center rounded-lg">
						<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M22 0H2C1.46957 0 0.960859 0.210714 0.585786 0.585786C0.210714 0.960859 0 1.46957 0 2V22C0 22.5304 0.210714 23.0391 0.585786 23.4142C0.960859 23.7893 1.46957 24 2 24H22C22.5304 24 23.0391 23.7893 23.4142 23.4142C23.7893 23.0391 24 22.5304 24 22V2C24 1.46957 23.7893 0.960859 23.4142 0.585786C23.0391 0.210714 22.5304 0 22 0ZM19 13H13V19C13 19.2652 12.8946 19.5196 12.7071 19.7071C12.5196 19.8946 12.2652 20 12 20C11.7348 20 11.4804 19.8946 11.2929 19.7071C11.1054 19.5196 11 19.2652 11 19V13H5C4.73478 13 4.48043 12.8946 4.29289 12.7071C4.10536 12.5196 4 12.2652 4 12C4 11.7348 4.10536 11.4804 4.29289 11.2929C4.48043 11.1054 4.73478 11 5 11H11V5C11 4.73478 11.1054 4.48043 11.2929 4.29289C11.4804 4.10536 11.7348 4 12 4C12.2652 4 12.5196 4.10536 12.7071 4.29289C12.8946 4.48043 13 4.73478 13 5V11H19C19.2652 11 19.5196 11.1054 19.7071 11.2929C19.8946 11.4804 20 11.7348 20 12C20 12.2652 19.8946 12.5196 19.7071 12.7071C19.5196 12.8946 19.2652 13 19 13Z" fill="#B6FFD3"/>
						</svg>
					</div>
					<div class="flex items-center justify-between gap-3">
						<div class="flex flex-col">
							<div class="fontBarlow text-xl font-semibold leading-5 text-[#B6FFD3]">Create Character</div>
							<div class="fontBarlow font-medium  text-[#B6FFD3] text-opacity-[58%] leading-5">Add Character</div>
						</div>
					</div>
					<svg class="absolute right-0" width="10" height="18" viewBox="0 0 10 18" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M1.75 15.875L8.625 9L1.75 2.125" stroke="white" stroke-width="2.75" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
			</div>
			`;

      $("#charList").append(createHtml);
    }
  }

  $(".createCharacterBtn").off("click");
  $(".createCharacterBtn").on("click", function () {
    $(".selectCharacterBtn").removeClass("opacity-100");
    $(".createCharacterBtn").removeClass("opacity-100");
    $(".selectCharacterBtn").addClass("opacity-50");
    $(".createCharacterBtn").addClass("opacity-50");
    $(this).removeClass("opacity-50");
    $(this).addClass("opacity-100");
    openCreateMenu();
  });

  if (maxSlots > maxCharLenght) {
    var count = maxSlots - maxCharLenght;

    for (var i = 0; i < count; i++) {
      var unlockHtml = `
			<div class="cursor-pointer charUnlockItem opacity-60 hover:opacity-100 transition-all rounded-md flex items-center relative py-2 px-3">
				<div class="relative flex items-center gap-3 w-full">
					<div class="absolute w-0.5 h-10 bg-[#FFE7A8] -left-3 rounded-lg top-0 bottom-0 my-auto">

					</div>
					<div class="w-16 h-16 bg-white bg-opacity-[8%] flex items-center justify-center rounded-lg">
						<svg width="19" height="24" viewBox="0 0 19 24" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M2.28571 24C1.65714 24 1.11924 23.7764 0.672 23.3291C0.224762 22.8819 0.000761905 22.3436 0 21.7143V10.2857C0 9.65714 0.224 9.11924 0.672 8.672C1.12 8.22476 1.6579 8.00076 2.28571 8H3.42857V5.71429C3.42857 4.13333 3.9859 2.7859 5.10057 1.672C6.21524 0.558095 7.56267 0.000761905 9.14286 0C10.7238 0 12.0716 0.557333 13.1863 1.672C14.301 2.78667 14.8579 4.13409 14.8571 5.71429V8H16C16.6286 8 17.1669 8.224 17.6149 8.672C18.0629 9.12 18.2865 9.6579 18.2857 10.2857V21.7143C18.2857 22.3429 18.0621 22.8811 17.6149 23.3291C17.1676 23.7771 16.6293 24.0008 16 24H2.28571ZM9.14286 18.2857C9.77143 18.2857 10.3097 18.0621 10.7577 17.6149C11.2057 17.1676 11.4293 16.6293 11.4286 16C11.4286 15.3714 11.205 14.8335 10.7577 14.3863C10.3105 13.939 9.77219 13.715 9.14286 13.7143C8.51429 13.7143 7.97638 13.9383 7.52914 14.3863C7.0819 14.8343 6.8579 15.3722 6.85714 16C6.85714 16.6286 7.08114 17.1669 7.52914 17.6149C7.97714 18.0629 8.51505 18.2865 9.14286 18.2857ZM5.71429 8H12.5714V5.71429C12.5714 4.7619 12.2381 3.95238 11.5714 3.28571C10.9048 2.61905 10.0952 2.28571 9.14286 2.28571C8.19048 2.28571 7.38095 2.61905 6.71429 3.28571C6.04762 3.95238 5.71429 4.7619 5.71429 5.71429V8Z" fill="#FFE7A8"/>
						</svg>
					</div>
					<div class="flex items-center justify-between gap-3">
						<div class="flex flex-col">
							<div class="fontBarlow text-xl font-semibold leading-5 text-[#FFE7A8]">Unlock Slot</div>
							<div class="fontBarlow font-medium  text-[#FFE7A8] text-opacity-[58%] leading-5">Enter the key code</div>
						</div>
					</div>
					<svg class="absolute right-0" width="10" height="18" viewBox="0 0 10 18" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M1.75 15.875L8.625 9L1.75 2.125" stroke="white" stroke-width="2.75" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
				</div>
			</div>
			`;
      $("#charList").append(unlockHtml);
    }
  }
}

$(document).ready(function () {
  window.addEventListener("message", function (event) {
    console.log(event.data, JSON.stringify(event.data));
    switch (event.data.action) {
      case "open":
        $("body").removeClass("hidden");
        console.log(event.data.chars);
        loadChars(
          event.data.chars,
          event.data.maxValues,
          event.data.DefaultExtraCharacterSlots,
          event.data.MaxCharacterSlots
        );
        framework = event.data.framework;
        if (framework == "esx") {
          $("#nationalityCreate").addClass("hidden");
          $("#nationalitySelect").addClass("hidden");
        }
        $(".createCharacterBtn").off("click");
        $(".createCharacterBtn").on("click", function () {
          $(".selectCharacterBtn").removeClass("opacity-100");
          $(".createCharacterBtn").removeClass("opacity-100");
          $(this).removeClass("opacity-50");
          $(this).addClass("opacity-100");
          openCreateMenu();
        });

        $(".selectCharacterBtn").off("click");
        $(".selectCharacterBtn").on("click", function () {
          var charId = $(this).attr("data-charid");

          $(".selectCharacterBtn").removeClass("opacity-50");
          $(".selectCharacterBtn").removeClass("opacity-100");
          $(".selectCharacterBtn").addClass("opacity-50");

          $(this).removeClass("opacity-50");
          $(this).addClass("opacity-100");
          openSelectMenu(charId);
        });

        $(".charUnlockItem").off("click");
        $(".charUnlockItem").on("click", function () {
          openKeycodeMenu();
        });

        if (event.data.serverName) {
          $("#serverName").text(event.data.serverName);
        }

        if (event.data.serverDescription) {
          $("#serverDescription").text(event.data.serverDescription);
        }

        if (event.data.serverLogo) {
          $("#serverLogo").attr("src", event.data.serverLogo);
        }

        if (event.data.tebexStore) {
          $("#tebexStore").off("click");
          $("#tebexStore").on("click", function () {
            window.invokeNative("openUrl", event.data.tebexStore);
          });
        }

        if (event.data.selectedChar != null) {
          $(`[data-charid="${event.data.selectedChar}"]`).trigger("click");
        } else {
          $(".selectCharacterBtn").first().trigger("click");
        }
        break;
      case "close":
        $("body").addClass("hidden");
        break;
    }
  });

  $("#redeemBtn").on("click", function () {
    var keycode = $("#redeemInput").val();
    $.post(
      "http://izzy-multichar/redeemKeycode",
      JSON.stringify({ keycode: keycode }),
      function (data) {
        if (data == false) {
          errorNotify("Invalid keycode!");
        } else {
          closeKeycodeMenu();
        }
      }
    );
  });

  $("#closeKeycodeMenu").on("click", function () {
    closeKeycodeMenu();
  });

  $("#maleBtn").on("click", function () {
    $("#maleBtn").addClass("maleBtnActive");
    $("#femaleBtn").removeClass("femaleBtnActive");
    sex = "male";
    $.post(
      "http://izzy-multichar/selectGender",
      JSON.stringify({ gender: sex })
    );
  });

  $("#femaleBtn").on("click", function () {
    $("#femaleBtn").addClass("femaleBtnActive");
    $("#maleBtn").removeClass("maleBtnActive");
    sex = "female";
    $.post(
      "http://izzy-multichar/selectGender",
      JSON.stringify({ gender: sex })
    );
  });

  $("#charCreateMonth").keyup(function () {
    var month = $("#charCreateMonth").val();
    if (month > 12) {
      $("#charCreateMonth").val("12");
    }
  });

  $("#charCreateDay").keyup(function () {
    var day = $("#charCreateDay").val();
    if (day > 31) {
      $("#charCreateDay").val("31");
    }
  });

  $("#charCreateYear").keyup(function () {
    var year = $("#charCreateYear").val();
    if (year > 2021) {
      $("#charCreateYear").val("2021");
    }
  });
});
