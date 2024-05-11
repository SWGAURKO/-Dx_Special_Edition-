let maxValues = [];
let cachedMugshotCount = 0;

let currentIndex = 2;

let currentOpenType = "character";

function getBase64Image(src, callback, outputFormat) {
  const img = new Image();
  img.crossOrigin = "Anonymous";
  img.onload = () => {
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    let dataURL;
    canvas.height = img.naturalHeight;
    canvas.width = img.naturalWidth;
    ctx.drawImage(img, 0, 0);
    dataURL = canvas.toDataURL(outputFormat);
    callback(dataURL);
  };

  img.src = src;
  if (img.complete || img.complete === undefined) {
    img.src = src;
  }
}

function Convert(pMugShotTxd, id) {
  let tempUrl =
    "https://nui-img/" +
    pMugShotTxd +
    "/" +
    pMugShotTxd +
    "?t=" +
    String(Math.round(new Date().getTime() / 1000));
  if (pMugShotTxd == "none") {
    tempUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg";
  }
  getBase64Image(tempUrl, function (dataUrl) {
    $.post(
      `https://${GetParentResourceName()}/Answer`,
      JSON.stringify({
        Answer: dataUrl,
        Id: id,
      })
    );
  });
}

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
  $("#errorBoxClass").click(function () {
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

function registerSavedSkins(data) {
  $("#savedSkins").html("");
  cachedMugshotCount = data.length;
  for (var i = 0; i < data.length; i++) {
    $("#savedSkins").append(`
        <div id="mugshot${data[i].id}" class="relative cursor-pointer overflow-hidden backdrop-blur-[5.5px] mb-[6px] bg-white bg-opacity-[0.06] h-[76px] w-[76px] rounded-[4px] flex items-center justify-center">
            <img class="w-full h-full cursor-pointer" src="${data[i].mugshot}" alt="">
            <div id="mugshotDelete${data[i].id}" class="opacity-0 absolute w-full h-full backdrop-blur-[7px] bg-black bg-opacity-30 flex items-center justify-center">
                <svg class="deleteIconShadow" width="18" height="25" viewBox="0 0 14 18" xmlns="http://www.w3.org/2000/svg">
                    <path d="M14 1H10.5L9.5 0H4.5L3.5 1H0V3H14M1 16C1 16.5304 1.21071 17.0391 1.58579 17.4142C1.96086 17.7893 2.46957 18 3 18H11C11.5304 18 12.0391 17.7893 12.4142 17.4142C12.7893 17.0391 13 16.5304 13 16V4H1V16Z" fill="#E32B2B"/>
                </svg>
            </div>
        </div>
        `);

    $("#mugshot" + data[i].id).off("click");
    $("#mugshot" + data[i].id).click(function () {
      var id = $(this).attr("id").replace("mugshot", "");

      if ($("#mugshotDelete" + id).css("opacity") == 1) {
        return;
      }

      console.log(currentOpenType);

      $.post(
        "https://izzy-appearance/loadSkinData",
        JSON.stringify({
          id: id,
          type: currentOpenType,
        })
      );
    });

    $("#mugshot" + data[i].id).off("contextmenu");
    $("#mugshot" + data[i].id).contextmenu(function () {
      var id = $(this).attr("id").replace("mugshot", "");

      $("#mugshotDelete" + id).animate(
        {
          opacity: 1,
        },
        250
      );

      $("#mugshotDelete" + id).off("click");
      $("#mugshotDelete" + id).click(function () {
        $.post(
          "https://izzy-appearance/deleteSkinData",
          JSON.stringify({
            id: id,
            type: currentOpenType,
          }),
          function (data) {
            $("#mugshotDelete" + id).off("click");
            registerSavedSkins(data);
          }
        );
      });

      setTimeout(function () {
        $("#mugshotDelete" + id).animate(
          {
            opacity: 0,
          },
          250
        );
        $("#mugshotDelete" + id).off("click");
      }, 1000);
    });
  }
}

$(document).ready(function () {
  let isMiddleMouseDown = false;
  let inPhotoMode = false;

  // randomCharBtn
  $("#randomCharBtn").click(function () {
    $.post(
      "https://izzy-appearance/randomChar",
      JSON.stringify({ type: currentOpenType })
    );
  });

  $("#saveCharBtn").click(function () {
    $.post("https://izzy-appearance/saveSkin", JSON.stringify({}));
    $.post("https://izzy-appearance/close", JSON.stringify({}));
    $(".bodyBGG").addClass("hidden");
  });

  $(document).keyup(function (e) {
    if (e.key === "Escape") {
      if (inPhotoMode == false) {
        if (currentOpenType == "clothing") {
          $.post(
            "https://izzy-appearance/closeWithoutPay",
            JSON.stringify({ status: false })
          );
          $(".bodyBGG").addClass("hidden");
        }

        if (currentOpenType == "barber") {
          $.post(
            "https://izzy-appearance/closeWithoutPay",
            JSON.stringify({ status: false })
          );
          $(".bodyBGG").addClass("hidden");
        }

        if (currentOpenType == "surgery") {
          $.post(
            "https://izzy-appearance/closeWithoutPay",
            JSON.stringify({ status: false })
          );
          $(".bodyBGG").addClass("hidden");
        }
      }
    }
  });

  $("#photoModeBtn").click(function () {
    $.post(
      "https://izzy-appearance/photoMode",
      JSON.stringify({ status: true })
    );
    $(".bodyBGG").addClass("hidden");
    inPhotoMode = true;

    // if press escape
    $(document).keyup(function (e) {
      if (e.key === "Escape") {
        if (inPhotoMode == true) {
          $.post(
            "https://izzy-appearance/photoMode",
            JSON.stringify({ status: false })
          );
          inPhotoMode = false;
          setTimeout(function () {
            $(".bodyBGG").removeClass("hidden");
          }, 500);
        }
      }
    });
  });

  document.body.addEventListener("mousedown", (event) => {
    if (event.button === 1) {
      isMiddleMouseDown = true;
    }
  });

  document.body.addEventListener("mouseup", (event) => {
    if (event.button === 1) {
      isMiddleMouseDown = false;
    }
  });

  document.body.addEventListener("mousemove", (event) => {
    if (isMiddleMouseDown) {
      const deltaX = event.movementX;
      postMouseDataToLua(deltaX);
    }
  });

  function postMouseDataToLua(deltaX) {
    $.post(
      "https://izzy-appearance/mouseData",
      JSON.stringify({
        deltaX: deltaX,
      })
    );
  }

  let values = {
    arms: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    "t-shirt": {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
        15: {
          value: 0,
          max: 0,
        },
      },
    },
    torso2: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    pants: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    shoes: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    vest: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    decals: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    accessory: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    mask: {
      type: "item",
      min: 0,
      value: 0,
      max: 0,
      hasTexture: {},
    },
    hat: {
      type: "item",
      min: -1,
      value: -1,
      max: 0,
      hasTexture: {},
    },
    ear: {
      type: "item",
      min: -1,
      value: -1,
      max: 0,
      hasTexture: {},
    },
    watch: {
      type: "item",
      min: -1,
      value: -1,
      max: 0,
      hasTexture: {},
    },
    bracelet: {
      type: "item",
      min: -1,
      value: -1,
      max: 0,
      hasTexture: {},
    },
    glass: {
      type: "item",
      min: 0,
      value: 0,
      max: 0,
      hasTexture: {},
    },
    bag: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    beard: {
      type: "item",
      value: 0,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    lipstick: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    lips_thickness: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: false,
    },
    jaw_bone_width: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    jaw_bone_back_lenght: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    chimp_bone_lowering: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    chimp_bone_lenght: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    chimp_bone_width: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    chimp_hole: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    neck_thikness: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    hair: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: {},
    },
    eye_color: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: false,
    },
    moles: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    nose_0: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    nose_1: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    nose_2: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    nose_3: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    nose_4: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    nose_5: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    eyebrown_high: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    eyebrown_forward: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    cheek_1: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    cheek_2: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    cheek_3: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    eye_opening: {
      type: "item",
      value: 0,
      min: 0,
      max: 0,
      hasTexture: false,
    },
    eyebrows: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    blush: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
    makeup: {
      type: "item",
      value: -1,
      min: -1,
      max: 0,
      hasTexture: {
        1: {
          value: 0,
          max: 0,
        },
      },
    },
  };

  $("#saveSkinDataBtn").click(function () {
    if (cachedMugshotCount >= 6) return;
    $.post(
      "https://izzy-appearance/saveSkinData",
      JSON.stringify({
        values: values,
        type: currentOpenType,
      }),
      function (data) {
        registerSavedSkins(data);
      }
    );
  });

  function resetAllValues() {
    for (var key in values) {
      values[key].value = 0;
      if (values[key].hasTexture != false) {
        values[key].hasTexture[values[key].value] = {
          value: 0,
          max: 0,
        };
        $("#" + key + "TextureValue").val(
          values[key].hasTexture[values[key].value].value
        );
        $("#" + key + "Texture").slider(
          "value",
          values[key].hasTexture[values[key].value].value
        );
      }

      $("#" + key + "Value").val(values[key].value);

      $("#" + key).slider("value", values[key].value);

      if (key == "t-shirt") {
        values[key].value = 15;
        values[key].hasTexture[values[key].value].value = 0;

        $("#" + key + "Value").val(values[key].value);
        $("#" + key + "TextureValue").val(
          values[key].hasTexture[values[key].value].value
        );

        $("#" + key).slider("value", values[key].value);
        $("#" + key + "Texture").slider(
          "value",
          values[key].hasTexture[values[key].value].value
        );
      }
    }

    selectedDad = 0;
    selectedMom = 0;

    dadSimilarity = 0;
    momSimilarity = 0;

    $("#dadSimilarity").slider("value", 0);
    $("#momSimilarity").slider("value", 0);

    $("#dadsBtn").click();
  }

  window.addEventListener("message", function (event) {
    if (event.data.translations != undefined) {
      translations = event.data.translations;
      translate();
    }

    let msg = event.data;
    if (msg.type == "convert") {
      Convert(msg.pMugShotTxd, msg.id);
    }

    switch (event.data.action) {
      case "contextOpen":
        $("#contextBtnText").text(event.data.text);
        $("#contextBtn").removeClass("left-[-200px]");
        break;
      case "contextClose":
        $("#contextBtnText").text(event.data.text);
        $("#contextBtn").addClass("left-[-200px]");
        break;
      case "open":
        $("#leftMenu").show();
        $("#categories").show();

        $("#beardFaceSettings").removeClass("hidden");
        $("#beardBeardSettings").removeClass("hidden");
        $("#sexSection").removeClass("hidden");

        $("#saveCharBtnText").html(`SAVE CHARACTER`);

        currentOpenType = "character";
        $(".category-btn").removeClass("opacity-0");

        $(".category-btn").addClass("opacity-50");
        $(".category-btn").addClass("cursor-pointer");

        $("#saveCharBtn").off("click");
        $("#saveCharBtn").click(function () {
          $.post("https://izzy-appearance/saveSkin", JSON.stringify({}));
          $.post("https://izzy-appearance/close", JSON.stringify({}));
          $(".bodyBGG").addClass("hidden");
        });

        $(".category-btn").click(function () {
          $(".categoryGroup").fadeOut(100);
          var category = $(this).attr("data-category");
          var cam = $(this).attr("data-cam");

          $.post(
            "https://izzy-appearance/setupCam",
            JSON.stringify({
              value: parseInt(cam),
            })
          );

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $(".category-btn").removeClass("active-menu-content");
          $(".category-btn").addClass("opacity-50");
          $(".category-btn").removeClass("h-[227px]");
          $(".category-btn").addClass("h-[200px]");

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200;
          $("#ustGradient").css("height", height - 5);
          $("#activeGradient").css("top", index * 200 - 200 + 27 + 27 + "px");

          $("#altGradient").css("height", testII * 200 + 15 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#firstZa").click();

        $(".bodyBGG").removeClass("hidden");
        $.post(
          "https://izzy-appearance/setupCam",
          JSON.stringify({
            value: 1,
          })
        );

        if (event.data.gender == 1) {
          $("#femaleBtn").click();
        }

        if (event.data.gender == 0) {
          $("#maleBtn").click();
        }

        registerSavedSkins(event.data.saved);
        break;
      case "openClothing":
        $("#leftMenu").show();
        $("#categories").show();

        $("#saveCharBtnText").html(`Buy Clothes ($${event.data.price})`);
        currentOpenType = "clothing";

        $(".category-btn").removeClass("opacity-50");
        $(".category-btn").removeClass("cursor-pointer");
        $(".category-btn").addClass("opacity-0");

        $(".category-app-btn").removeClass("opacity-0");
        $(".category-btn").off("click");

        $(".category-app-btn").off("click");
        $(".category-app-btn").click(function () {
          $(".categoryGroup").fadeOut(100);
          var category = $(this).attr("data-category");
          var cam = $(this).attr("data-cam");

          $.post(
            "https://izzy-appearance/setupCam",
            JSON.stringify({
              value: parseInt(cam),
            })
          );

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200;
          $("#ustGradient").css("height", height - 5);
          $("#activeGradient").css("top", index * 200 - 200 + 27 + 27 + "px");

          $("#altGradient").css("height", testII * 200 + 15 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#appearenceCategoryBtn").addClass("cursor-pointer");

        $("#appearenceCategoryBtn").click();

        $(".bodyBGG").removeClass("hidden");

        $.post(
          "https://izzy-appearance/setupCam",
          JSON.stringify({
            value: 4,
          })
        );

        $("#saveCharBtn").off("click");
        $("#saveCharBtn").click(function () {
          if (currentOpenType == "clothing") {
            $.post(
              "https://izzy-appearance/buyClothing",
              JSON.stringify({ type: currentOpenType }),
              function (data) {
                if (data.status == false) {
                  errorNotify("You don't have enough money.");
                } else {
                  $.post(
                    "https://izzy-appearance/saveClothing",
                    JSON.stringify({})
                  );
                  $.post("https://izzy-appearance/close", JSON.stringify({}));
                  $(".bodyBGG").addClass("hidden");
                }
              }
            );
          } else {
            $.post("https://izzy-appearance/saveClothing", JSON.stringify({}));
            $.post("https://izzy-appearance/close", JSON.stringify({}));
            $(".bodyBGG").addClass("hidden");
          }
        });

        registerSavedSkins(event.data.saved);
        break;
      case "openClothingRoom":
        $("#saveCharBtnText").html(`SAVE OUTFIT`);
        currentOpenType = "clothing_room";

        $(".category-btn").removeClass("opacity-50");
        $(".category-btn").removeClass("cursor-pointer");
        $(".category-btn").addClass("opacity-0");

        $(".category-app-btn").removeClass("opacity-0");
        $(".category-btn").off("click");

        $(".category-app-btn").off("click");
        $(".category-app-btn").click(function () {
          $(".categoryGroup").fadeOut(100);
          var category = $(this).attr("data-category");
          var cam = $(this).attr("data-cam");

          $.post(
            "https://izzy-appearance/setupCam",
            JSON.stringify({
              value: parseInt(cam),
            })
          );

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200;
          $("#ustGradient").css("height", height - 5);
          $("#activeGradient").css("top", index * 200 - 200 + 27 + 27 + "px");

          $("#altGradient").css("height", testII * 200 + 15 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#leftMenu").hide();
        $("#categories").hide();
        $("#randomChar").hide();
        $(".bodyBGG").removeClass("hidden");

        $.post(
          "https://izzy-appearance/setupCam",
          JSON.stringify({
            value: 4,
          })
        );

        $("#saveCharBtn").off("click");
        $("#saveCharBtn").click(function () {
          if (currentOpenType == "clothing_room") {
            $.post("https://izzy-appearance/saveClothing", JSON.stringify({}));
            $.post("https://izzy-appearance/close", JSON.stringify({}));
            $(".bodyBGG").addClass("hidden");
          } else {
            $.post("https://izzy-appearance/saveClothing", JSON.stringify({}));
            $.post("https://izzy-appearance/close", JSON.stringify({}));
            $(".bodyBGG").addClass("hidden");
          }
        });

        registerSavedSkins(event.data.saved);
        break;
      case "openBarber":
        $("#leftMenu").show();
        $("#categories").show();
        $("#randomChar").show();

        $("#beardFaceSettings").addClass("hidden");
        $("#beardBeardSettings").removeClass("hidden");
        $("#saveCharBtnText").html(`Buy Haircut ($${event.data.price})`);
        currentOpenType = "barber";

        $(".category-btn").removeClass("opacity-50");
        $(".category-btn").removeClass("cursor-pointer");
        $(".category-btn").addClass("opacity-0");

        $("#hairCategoryBtn").removeClass("opacity-0");
        // $("#beardCategoryBtn").removeClass("opacity-0");
        $("#beardCategoryBtn").addClass("opacity-50");

        $(".category-btn").off("click");

        $("#hairCategoryBtn").addClass("cursor-pointer");
        $("#beardCategoryBtn").addClass("cursor-pointer");

        $("#hairCategoryBtn").addClass("z-40");
        $("#beardCategoryBtn").addClass("z-40");

        $("#beardCategoryBtn").off("click");
        $("#beardCategoryBtn").click(function () {
          $(".categoryGroup").fadeOut(100);
          var category = $(this).attr("data-category");

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $("#beardCategoryBtn").removeClass("active-menu-content");
          $("#hairCategoryBtn").removeClass("active-menu-content");

          $("#beardCategoryBtn").addClass("opacity-50");
          $("#hairCategoryBtn").addClass("opacity-50");

          $("#beardCategoryBtn").removeClass("h-[227px]");
          $("#hairCategoryBtn").removeClass("h-[227px]");

          $("#beardCategoryBtn").addClass("h-[200px]");
          $("#hairCategoryBtn").addClass("h-[200px]");

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-0");
          $(this).removeClass("opacity-0");
          $(this).removeClass("opacity-50");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200 + 22;
          $("#ustGradient").css("height", height);
          $("#altGradient").css("height", testII * 200 - 15 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + 27 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#hairCategoryBtn").off("click");
        $("#hairCategoryBtn").click(function () {
          $(".categoryGroup").fadeOut(100);
          var category = $(this).attr("data-category");

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $("#beardCategoryBtn").removeClass("active-menu-content");
          $("#hairCategoryBtn").removeClass("active-menu-content");

          $("#beardCategoryBtn").addClass("opacity-50");
          $("#hairCategoryBtn").addClass("opacity-50");

          $("#beardCategoryBtn").removeClass("h-[227px]");
          $("#hairCategoryBtn").removeClass("h-[227px]");

          $("#beardCategoryBtn").addClass("h-[200px]");
          $("#hairCategoryBtn").addClass("h-[200px]");

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-0");
          $(this).removeClass("opacity-0");
          $(this).removeClass("opacity-50");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200 + 22;
          $("#ustGradient").css("height", height);
          $("#altGradient").css("height", testII * 200 - 10 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + 27 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#hairCategoryBtn").click();

        $(".bodyBGG").removeClass("hidden");

        $.post(
          "https://izzy-appearance/setupCam",
          JSON.stringify({
            value: 1,
          })
        );

        $("#saveCharBtn").off("click");
        $("#saveCharBtn").click(function () {
          if (currentOpenType == "barber") {
            $.post(
              "https://izzy-appearance/buyClothing",
              JSON.stringify({ type: currentOpenType }),
              function (data) {
                if (data.status == false) {
                  errorNotify("You don't have enough money.");
                } else {
                  $.post(
                    "https://izzy-appearance/saveClothing",
                    JSON.stringify({})
                  );
                  $.post("https://izzy-appearance/close", JSON.stringify({}));
                  $(".bodyBGG").addClass("hidden");
                }
              }
            );
          } else {
            $.post("https://izzy-appearance/saveClothing", JSON.stringify({}));
            $.post("https://izzy-appearance/close", JSON.stringify({}));
            $(".bodyBGG").addClass("hidden");
          }
        });

        registerSavedSkins(event.data.saved);
        break;
      case "openSurgery":
        $("#leftMenu").show();
        $("#categories").show();

        $("#beardFaceSettings").removeClass("hidden");
        $("#beardBeardSettings").addClass("hidden");
        $("#sexSection").addClass("hidden");

        $("#saveCharBtnText").html(`Buy Surgery ($${event.data.price})`);

        currentOpenType = "surgery";

        $("#saveCharBtn").off("click");
        $("#saveCharBtn").click(function () {
          if (currentOpenType == "surgery") {
            $.post(
              "https://izzy-appearance/buyClothing",
              JSON.stringify({ type: currentOpenType }),
              function (data) {
                if (data.status == false) {
                  errorNotify("You don't have enough money.");
                } else {
                  $.post(
                    "https://izzy-appearance/saveClothing",
                    JSON.stringify({})
                  );
                  $.post("https://izzy-appearance/close", JSON.stringify({}));
                  $(".bodyBGG").addClass("hidden");
                }
              }
            );
          } else {
            $.post("https://izzy-appearance/saveClothing", JSON.stringify({}));
            $.post("https://izzy-appearance/close", JSON.stringify({}));
            $(".bodyBGG").addClass("hidden");
          }
        });

        $(".category-btn").removeClass("opacity-0");

        $(".category-btn").addClass("opacity-50");
        $(".category-btn").addClass("cursor-pointer");

        $(".category-btn").off("click");
        $(".category-btn").click(function () {
          var category = $(this).attr("data-category");

          if (category == "HAIR") {
            errorNotify("You can't change your hair in surgery.");
            return;
          }

          if (category == "APPEARENCE") {
            errorNotify("You can't change your outfit in surgery.");
            return;
          }

          $(".categoryGroup").fadeOut(100);
          console.log(category);

          var cam = $(this).attr("data-cam");

          $.post(
            "https://izzy-appearance/setupCam",
            JSON.stringify({
              value: parseInt(cam),
            })
          );

          setTimeout(function () {
            $("#" + category + "Category").fadeIn(100);
            $("#" + category + "Category").css("display", "flex");
          }, 100);

          $(".category-btn").removeClass("active-menu-content");
          $(".category-btn").addClass("opacity-50");
          $(".category-btn").removeClass("h-[227px]");
          $(".category-btn").addClass("h-[200px]");

          $(this).addClass("active-menu-content");
          $(this).removeClass("opacity-50");

          $(".my-4").removeClass("my-4");

          $(this).addClass("my-4");

          $(this).addClass("h-[227px]");

          var index = $(this).index() - 2;

          if (index == 1) {
            $("#ustGradient").css("height", "0px");
            $("#ustGradient").css("display", "none");

            $("#altGradient").css("height", "686px");
            $("#activeGradient").css("top", index * 200 - 200 + "px");
          } else {
            $("#ustGradient").css("display", "block");
          }

          $("#altGradient").css("display", "block");
          var testII = 5 - index;
          var testI = 5 - testII - 1;
          var height = testI * 200;
          $("#ustGradient").css("height", height - 5);
          $("#activeGradient").css("top", index * 200 - 200 + 27 + 27 + "px");

          $("#altGradient").css("height", testII * 200 + 15 + "px");
          $("#activeGradient").css("top", index * 200 - 200 + "px");

          if (index == 5) {
            $("#altGradient").css("display", "none");
          }

          $("#activeGradient").addClass("my-4");
          currentIndex = index;
        });

        $("#firstZa").click();

        $(".bodyBGG").removeClass("hidden");

        $.post(
          "https://izzy-appearance/setupCam",
          JSON.stringify({
            value: 1,
          })
        );

        registerSavedSkins(event.data.saved);
        break;
      case "close":
        $(".bodyBGG").addClass("hidden");
        break;
      case "setValues":
        var tempData = JSON.parse(event.data.values);

        for (let key in tempData) {
          if (values[key]) {
            values[key].value = tempData[key].item;

            $("#" + key + "Value").val(values[key].value);
            $("#" + key).slider("value", values[key].value);

            if (tempData[key].texture) {
              values[key].hasTexture[values[key].value] = {
                value: 0,
                max: 0,
              };

              values[key].hasTexture[values[key].value].value =
                tempData[key].texture;

              $("#" + key + "TextureValue").val(tempData[key].texture);
              $("#" + key + "Texture").slider("value", tempData[key].texture);
            }
          }
        }

        break;
      case "updateMax":
        maxValues = event.data.maxValues;
        for (let key in maxValues) {
          if (values[key]) {
            values[key].max = maxValues[key].item;
            $("#" + key + "Value").val(
              values[key].value ? values[key].value : "0"
            );
            $("#" + key + "Max").html("/" + maxValues[key].item);

            let keyy = key;

            $("#" + keyy).slider({
              range: "min",
              min: values[keyy].min ? values[keyy].min : 0,
              max: values[keyy].max,
              value: values[keyy].value,
              slide: function (event, ui) {
                var value = ui.value;

                values[keyy].value = value;
                $("#" + keyy + "Value").val(values[keyy].value);

                $.post(
                  "https://izzy-appearance/updateSkin",
                  JSON.stringify({
                    clothingType: keyy,
                    articleNumber: values[keyy].value,
                    type: "item",
                  })
                );
              },
            });

            $("#" + keyy + "Value").on("keyup", function (e) {
              var value = parseInt($(this).val());

              if (value > values[keyy].max) {
                value = values[keyy].max;
              }

              if (value < values[keyy].min) {
                value = values[keyy].min;
              }

              values[keyy].value = value;
              $("#" + keyy + "Value").val(values[keyy].value);

              $.post(
                "https://izzy-appearance/updateSkin",
                JSON.stringify({
                  clothingType: keyy,
                  articleNumber: values[keyy].value,
                  type: "item",
                })
              );
            });

            if (values[key].hasTexture !== false) {
              if (values[keyy].hasTexture[values[keyy].value] == undefined) {
                values[keyy].hasTexture[values[keyy].value] = {
                  value: 0,
                  max: maxValues[key].texture,
                };
              } else {
                values[keyy].hasTexture[values[keyy].value] = {
                  value: values[keyy].hasTexture[values[keyy].value].value,
                  max: maxValues[keyy].texture,
                };
              }

              $("#" + keyy + "TextureValue").val(
                values[keyy].hasTexture[values[keyy].value].value
              );
              $("#" + keyy + "TextureMax").html(
                "/" + values[keyy].hasTexture[values[keyy].value].max
              );

              $("#" + keyy + "Texture").slider({
                range: "min",
                min: 0,
                max: values[keyy].hasTexture[values[keyy].value].max,
                value: values[keyy].hasTexture[values[keyy].value].value,
                slide: function (event, ui) {
                  var value = ui.value;
                  console.log("kere keyyyy", values[keyy]);
                  values[keyy].hasTexture[values[keyy].value].value = value;
                  $("#" + keyy + "TextureValue").val(
                    values[keyy].hasTexture[values[keyy].value].value
                  );

                  $.post(
                    "https://izzy-appearance/updateSkin",
                    JSON.stringify({
                      clothingType: keyy,
                      articleNumber:
                        values[keyy].hasTexture[values[keyy].value].value,
                      type: "texture",
                    })
                  );
                },
              });

              $("#" + keyy + "TextureValue").on("keyup", function (e) {
                var value = parseInt($(this).val());

                if (value > values[keyy].hasTexture[values[keyy].value].max) {
                  value = values[keyy].hasTexture[values[keyy].value].max;
                }

                if (value < 0) {
                  value = 0;
                }

                values[keyy].hasTexture[values[keyy].value].value = value;
                $("#" + keyy + "TextureValue").val(
                  values[keyy].hasTexture[values[keyy].value].value
                );

                $.post(
                  "https://izzy-appearance/updateSkin",
                  JSON.stringify({
                    clothingType: keyy,
                    articleNumber:
                      values[keyy].hasTexture[values[keyy].value].value,
                    type: "texture",
                  })
                );
              });
            }
          }
        }
        break;
      case "updateMaxSinle":
        maxValues = event.data.maxValues;
        let singleKey = event.data.key;
        for (var key in maxValues) {
          if (key == singleKey) {
            if (values[key]) {
              values[key].max = maxValues[key].item;

              $("#" + key + "Value").val(
                values[key].value ? values[key].value : "0"
              );
              $("#" + key + "Max").html("/" + maxValues[key].item);

              let keyy = key;

              $("#" + keyy).slider({
                range: "min",
                min: values[keyy].min ? values[keyy].min : 0,
                max: values[keyy].max,
                value: values[keyy].value,
                slide: function (event, ui) {
                  var value = ui.value;

                  values[keyy].value = value;
                  $("#" + keyy + "Value").val(values[keyy].value);

                  $.post(
                    "https://izzy-appearance/updateSkin",
                    JSON.stringify({
                      clothingType: keyy,
                      articleNumber: values[keyy].value,
                      type: "item",
                    })
                  );
                },
              });

              if (values[keyy].hasTexture !== false) {
                values[keyy].hasTexture[values[keyy].value] = {
                  value: 0,
                  max: maxValues[keyy].texture,
                };

                $("#" + keyy + "TextureValue").val(
                  values[keyy].hasTexture[values[keyy].value].value
                );
                $("#" + keyy + "TextureMax").html(
                  "/" + values[keyy].hasTexture[values[keyy].value].max
                );

                $("#" + keyy + "Texture").slider({
                  range: "min",
                  min: 0,
                  max: values[keyy].hasTexture[values[keyy].value].max,
                  value: values[keyy].hasTexture[values[keyy].value].value,
                  slide: function (event, ui) {
                    var value = ui.value;

                    values[keyy].hasTexture[values[keyy].value].value = value;
                    $("#" + keyy + "TextureValue").val(
                      values[keyy].hasTexture[values[keyy].value].value
                    );

                    $.post(
                      "https://izzy-appearance/updateSkin",
                      JSON.stringify({
                        clothingType: keyy,
                        articleNumber:
                          values[keyy].hasTexture[values[keyy].value].value,
                        type: "texture",
                      })
                    );
                  },
                });
              }
            }
          }
        }
        break;
    }
  });

  $(".sliderGreen").slider({
    range: "min",
    min: 0,
    max: 100,
    value: 0,
    slide: function (event, ui) {},
  });

  $(".category-btn").click(function () {
    $(".categoryGroup").fadeOut(100);
    var category = $(this).attr("data-category");
    var cam = $(this).attr("data-cam");

    $.post(
      "https://izzy-appearance/setupCam",
      JSON.stringify({
        value: parseInt(cam),
      })
    );

    setTimeout(function () {
      $("#" + category + "Category").fadeIn(100);
      $("#" + category + "Category").css("display", "flex");
    }, 100);

    $(".category-btn").removeClass("active-menu-content");
    $(".category-btn").addClass("opacity-50");
    $(".category-btn").removeClass("h-[227px]");
    $(".category-btn").addClass("h-[200px]");

    $(this).addClass("active-menu-content");
    $(this).removeClass("opacity-50");

    $(".my-4").removeClass("my-4");

    $(this).addClass("my-4");

    $(this).addClass("h-[227px]");

    var index = $(this).index() - 2;

    if (index == 1) {
      $("#ustGradient").css("height", "0px");
      $("#ustGradient").css("display", "none");

      $("#altGradient").css("height", "686px");
      $("#activeGradient").css("top", index * 200 - 200 + "px");
    } else {
      $("#ustGradient").css("display", "block");
    }

    $("#altGradient").css("display", "block");
    var testII = 5 - index;
    var testI = 5 - testII - 1;
    var height = testI * 200;
    $("#ustGradient").css("height", height - 5);
    $("#activeGradient").css("top", index * 200 - 200 + 27 + 27 + "px");

    $("#altGradient").css("height", testII * 200 + 15 + "px");
    $("#activeGradient").css("top", index * 200 - 200 + "px");

    if (index == 5) {
      $("#altGradient").css("display", "none");
    }

    $("#activeGradient").addClass("my-4");
    currentIndex = index;
  });

  // DEFAULT VALUES
  var sex = "male";
  var selectedMom = 0;
  var selectedDad = 0;
  var dadSimilarity = 0;
  var momSimilarity = 0;

  function setGender(gender) {
    $.post(
      "https://izzy-appearance/setGender",
      JSON.stringify({
        gender: gender,
      })
    );
    resetAllValues();
  }

  $("#maleBtn").click(function () {
    $("#maleBtn").addClass("maleBtnActive");
    $("#femaleBtn").removeClass("femaleBtnActive");
    sex = "male";
    setGender(0);
  });

  $("#femaleBtn").click(function () {
    $("#femaleBtn").addClass("femaleBtnActive");
    $("#maleBtn").removeClass("maleBtnActive");
    sex = "female";
    setGender(1);
  });

  var dads = [
    {
      photo: "Adrian.png",
      name: "Adrian",
    },
    {
      photo: "Alex.png",
      name: "Alex",
    },
    {
      photo: "Andrew.png",
      name: "Andrew",
    },
    {
      photo: "Angel.png",
      name: "Angel",
    },
    {
      photo: "Anthony.png",
      name: "Anthony",
    },
    {
      photo: "Benjamin.png",
      name: "Benjamin",
    },
    {
      photo: "Daniel.png",
      name: "Daniel",
    },
    {
      photo: "Diego.png",
      name: "Diego",
    },
    {
      photo: "Ethan.png",
      name: "Ethan",
    },
    {
      photo: "Evan.png",
      name: "Evan",
    },
    {
      photo: "Gabriel.png",
      name: "Gabriel",
    },
    {
      photo: "Isaac.png",
      name: "Isaac",
    },
    {
      photo: "John.png",
      name: "John",
    },
    {
      photo: "Joshua.png",
      name: "Joshua",
    },
    {
      photo: "Juan.png",
      name: "Juan",
    },
    {
      photo: "Kevin.png",
      name: "Kevin",
    },
    {
      photo: "Louis.png",
      name: "Louis",
    },
    {
      photo: "Michael.png",
      name: "Michael",
    },
    {
      photo: "Niko.png",
      name: "Niko",
    },
    {
      photo: "Noah.png",
      name: "Noah",
    },
    {
      photo: "Samuel.png",
      name: "Samuel",
    },
    {
      photo: "Santiago.png",
      name: "Santiago",
    },
    {
      photo: "Vincent.png",
      name: "Vincent",
    },
  ];

  var moms = [
    {
      photo: "Amelia.png",
      name: "Amelia",
    },
    {
      photo: "Ashley.png",
      name: "Ashley",
    },
    {
      photo: "Audrey.png",
      name: "Audrey",
    },
    {
      photo: "Ava.png",
      name: "Ava",
    },
    {
      photo: "Brianna.png",
      name: "Brianna",
    },
    {
      photo: "Camila.png",
      name: "Camila",
    },
    {
      photo: "Charlotte.png",
      name: "Charlotte",
    },
    {
      photo: "Elizabeth.png",
      name: "Elizabeth",
    },
    {
      photo: "Emma.png",
      name: "Emma",
    },
    {
      photo: "Evelyn.png",
      name: "Evelyn",
    },
    {
      photo: "Giselle.png",
      name: "Giselle",
    },
    {
      photo: "Grace.png",
      name: "Grace",
    },
    {
      photo: "Hannah.png",
      name: "Hannah",
    },
    {
      photo: "Isabelle.png",
      name: "Isabelle",
    },
    {
      photo: "Jasmine.png",
      name: "Jasmine",
    },
    {
      photo: "Misty.png",
      name: "Misty",
    },
    {
      photo: "Natalie.png",
      name: "Natalie",
    },
    {
      photo: "Nicole.png",
      name: "Nicole",
    },
    {
      photo: "Olivia.png",
      name: "Olivia",
    },
    {
      photo: "Sophia.png",
      name: "Sophia",
    },
    {
      photo: "Violet.png",
      name: "Violet",
    },
    {
      photo: "Zoe.png",
      name: "Zoe",
    },
  ];

  var selectedParentTab = "dads";

  var html = "";

  for (var i = 0; i < dads.length; i++) {
    var activeClass = "";
    if (i == selectedDad) {
      activeClass = "parentItemActive";
    }
    html += `
        <div class="cursor-pointer uppercase parentItem ${activeClass} w-[97px] h-[107px] flex flex-col items-center justify-end text-[12px]">
            ${dads[i].name.toUpperCase()}
            <img class="h-20" src="img/dads/${dads[i].photo}" alt="">
        </div>
        `;
  }

  $("#parentsDiv").html(html);

  $("#dadsBtn").click(function () {
    $("#dadsBtn").addClass("parentBtnLeftActive");
    $("#momsBtn").removeClass("parentBtnRightActive");

    selectedParentTab = "dads";

    var html = "";

    for (var i = 0; i < dads.length; i++) {
      var activeClass = "";
      if (i == selectedDad) {
        activeClass = "parentItemActive";
      }

      html += `
            <div class="cursor-pointer uppercase parentItem ${activeClass} w-[97px] h-[107px] flex flex-col items-center justify-end text-[12px]">
                ${dads[i].name.toUpperCase()}
                <img class="h-20" src="img/dads/${dads[i].photo}" alt="">
            </div>
            `;
    }

    $("#parentsDiv").html(html);
    $(".parentItem").off("click");
    $(".parentItem").click(function () {
      $(".parentItem").removeClass("parentItemActive");
      $(this).addClass("parentItemActive");

      if (selectedParentTab == "dads") {
        selectedDad = $(this).index();
        $.post(
          "https://izzy-appearance/updateSkin",
          JSON.stringify({
            clothingType: "face2",
            articleNumber: selectedDad,
            type: "item",
          })
        );
        $.post(
          "https://izzy-appearance/updateSkin",
          JSON.stringify({
            clothingType: "face2",
            articleNumber: 15,
            type: "texture",
          })
        );
      }
    });
  });

  $("#momsBtn").click(function () {
    $("#momsBtn").addClass("parentBtnRightActive");
    $("#dadsBtn").removeClass("parentBtnLeftActive");

    selectedParentTab = "moms";

    var html = "";

    for (var i = 0; i < moms.length; i++) {
      var activeClass = "";

      if (i == selectedMom) {
        activeClass = "parentItemActive";
      }

      html += `
            <div class="cursor-pointer uppercase parentItem ${activeClass} w-[97px] h-[107px] flex flex-col items-center justify-end text-[12px]">
                ${moms[i].name.toUpperCase()}
                <img class="h-20" src="img/moms/${moms[i].photo}" alt="">
            </div>
            `;
    }

    $("#parentsDiv").html(html);

    $(".parentItem").off("click");
    $(".parentItem").click(function () {
      $(".parentItem").removeClass("parentItemActive");
      $(this).addClass("parentItemActive");

      if (selectedParentTab == "dads") {
        selectedDad = $(this).index();
        $.post(
          "https://izzy-appearance/updateSkin",
          JSON.stringify({
            clothingType: "face2",
            articleNumber: selectedDad,
            type: "item",
          })
        );
        $.post(
          "https://izzy-appearance/updateSkin",
          JSON.stringify({
            clothingType: "face2",
            articleNumber: 15,
            type: "texture",
          })
        );
      }

      if (selectedParentTab == "moms") {
        selectedMom = $(this).index();
        $.post(
          "https://izzy-appearance/updateSkin",
          JSON.stringify({
            clothingType: "face",
            articleNumber: selectedMom,
            type: "item",
          })
        );
      }
    });
  });

  $(".parentItem").off("click");
  $(".parentItem").click(function () {
    $(".parentItem").removeClass("parentItemActive");
    $(this).addClass("parentItemActive");

    if (selectedParentTab == "dads") {
      selectedDad = $(this).index();
    }

    if (selectedParentTab == "moms") {
      selectedMom = $(this).index();
    }
  });

  $("#dadSimilarity").on("slidechange", function () {
    var value = $(this).slider("option", "value");

    dadSimilarity = value / 100;

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: "facemix",
        articleNumber: dadSimilarity,
        type: "skinMix",
      })
    );
  });

  $("#momSimilarity").on("slidechange", function () {
    var value = $(this).slider("option", "value");

    momSimilarity = value / 100;

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: "facemix",
        articleNumber: momSimilarity,
        type: "shapeMix",
      })
    );
  });

  $(".sliderNegative").click(function () {
    var slider = $(this).attr("data-slider");

    values[slider].value = values[slider].value - 1;

    if (values[slider].value < values[slider].min) {
      values[slider].value = values[slider].min;
    }

    $("#" + slider + "Value").val(values[slider].value);
    $("#" + slider).slider("value", values[slider].value);

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: slider,
        articleNumber: values[slider].value,
        type: "item",
      })
    );
  });

  $(".sliderPositive").click(function () {
    var slider = $(this).attr("data-slider");

    values[slider].value = values[slider].value + 1;

    if (values[slider].value > values[slider].max) {
      values[slider].value = values[slider].max;
    }

    $("#" + slider + "Value").val(values[slider].value);
    $("#" + slider).slider("value", values[slider].value);

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: slider,
        articleNumber: values[slider].value,
        type: "item",
      })
    );
  });

  $(".sliderNegativeTexture").click(function () {
    var slider = $(this).attr("data-slider");

    values[slider].hasTexture[values[slider].value].value =
      values[slider].hasTexture[values[slider].value].value - 1;

    if (values[slider].hasTexture[values[slider].value].value < 0) {
      values[slider].hasTexture[values[slider].value].value = 0;
    }

    $("#" + slider + "TextureValue").val(
      values[slider].hasTexture[values[slider].value].value
    );
    $("#" + slider + "Texture").slider(
      "value",
      values[slider].hasTexture[values[slider].value].value
    );

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: slider,
        articleNumber: values[slider].hasTexture[values[slider].value].value,
        type: "texture",
      })
    );
  });

  $(".sliderPositiveTexture").click(function () {
    var slider = $(this).attr("data-slider");

    if (
      values[slider].hasTexture[values[slider].value].value >=
      values[slider].hasTexture[values[slider].value].max
    ) {
      values[slider].hasTexture[values[slider].value].value =
        values[slider].hasTexture[values[slider].value].max;
    } else {
      values[slider].hasTexture[values[slider].value].value =
        values[slider].hasTexture[values[slider].value].value + 1;
    }

    $("#" + slider + "TextureValue").val(
      values[slider].hasTexture[values[slider].value].value
    );
    $("#" + slider + "Texture").slider(
      "value",
      values[slider].hasTexture[values[slider].value].value
    );

    $.post(
      "https://izzy-appearance/updateSkin",
      JSON.stringify({
        clothingType: slider,
        articleNumber: values[slider].hasTexture[values[slider].value].value,
        type: "texture",
      })
    );
  });
});
