<%
    ui.includeFragment("appui", "standardEmrIncludes")
    ui.includeCss("referenceapplication", "styleguide.scss")
%>

<!DOCTYPE html>
<html>
<head>
    <title>${ ui.message("referenceapplication.login.title") }</title>
    <link rel="shortcut icon" type="image/ico" href="/${ ui.contextPath() }/images/openmrs-favicon.ico"/>
    <link rel="icon" type="image/png\" href="/${ ui.contextPath() }/images/openmrs-favicon.png"/>
    ${ ui.resourceLinks() }
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body class="container-fluid">
<script type="text/javascript">
    var OPENMRS_CONTEXT_PATH = '${ ui.contextPath() }';
</script>


${ ui.includeFragment("referenceapplication", "infoAndErrorMessages") }

<script type="text/javascript">
    jQuery(function() {
    	updateSelectedOption = function() {
	        jQuery('#sessionLocation li').removeClass('selected');
	        
			var sessionLocationVal = jQuery('#sessionLocationInput').val();
	        if(sessionLocationVal != null && sessionLocationVal != "" && sessionLocationVal != 0){
	            jQuery('#sessionLocation li[value|=' + sessionLocationVal + ']').addClass('selected');
	        }
    	};
    
        updateSelectedOption();

        jQuery('#sessionLocation li').click( function() {
            jQuery('#sessionLocationInput').val(jQuery(this).attr("value"));
            updateSelectedOption();
        });
		jQuery('#sessionLocation li').focus( function() {
            jQuery('#sessionLocationInput').val(jQuery(this).attr("value"));
            updateSelectedOption();
        });
		
		// If <Enter> Key is pressed, submit the form
		jQuery('#sessionLocation').keyup(function (e) {
    		var key = e.which || e.keyCode;
    		if (key === 13) {
      			jQuery('#login-form').submit();
    		}
		});
		var  listItem = Array.from(jQuery('#sessionLocation li'));
		for (var i in  listItem){
			 listItem[i].setAttribute('data-key', i);
			 listItem[i].addEventListener('keyup', function (event){
				var keyCode = event.which || event.keyCode;
				switch (keyCode) {
					case 37: // move left
						jQuery(this).prev('#sessionLocation li').focus();
						break;
					case 39: // move right
						jQuery(this).next('#sessionLocation li').focus();
						break;
					case 38: // move up
						jQuery('#sessionLocation li[data-key=' +(Number(jQuery(document.activeElement).attr('data-key')) - 3) + ']').focus(); 
						break;
					case 40: //	move down
						jQuery('#sessionLocation li[data-key=' +(Number(jQuery(document.activeElement).attr('data-key')) + 3) + ']').focus(); 
						break;
					default: break;
				}
			});
		}
		
        jQuery('#loginButton').click(function(e) {
        	var sessionLocationVal = jQuery('#sessionLocationInput').val();
        	
        	if (!sessionLocationVal) {
       			jQuery('#sessionLocationError').show(); 		
        		e.preventDefault();
        	}
        });	
		
        var cannotLoginController = emr.setupConfirmationDialog({
            selector: '#cannotLoginPopup',
            actions: {
                confirm: function() {
                    cannotLoginController.close();
                }
            }
        });
        
		jQuery('#username').focus();
        jQuery('a#cantLogin').click(function() {
            cannotLoginController.show();
        });
        
        pageReady = true;
    });
</script>
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="${ui.pageLink("referenceapplication", "home")}">
        <img alt="Brand" src="${ui.resourceLink("referenceapplication", "images/openMrsLogo.png")}">
      </a>
    </div>
  </div>
</nav>
<div id="body-wrapper">
    <div id="content">
        <form id="login-form" method="post" autocomplete="off">
            <fieldset>

                <legend>
                    <i class="icon-lock small"></i>
                    ${ ui.message("referenceapplication.login.loginHeading") }
                </legend>

                <div class="col-sm-6 form-group">
                    <div for="username">
                        ${ ui.message("referenceapplication.login.username") }:
                    </div>
                    <input id="username" class="form-control" type="text" name="username" placeholder="${ ui.message("referenceapplication.login.username.placeholder") }"/>
                </div>

                <div class="col-sm-6 form-group">
                    <div for="password">
                        ${ ui.message("referenceapplication.login.password") }:
                    </div>
                    <input id="password" type="password"  class="form-control" name="password" placeholder="${ ui.message("referenceapplication.login.password.placeholder") }"/>
                </div>

                <div class="col-xs-12">
                    <div for="sessionLocation">
                        ${ ui.message("referenceapplication.login.sessionLocation") }: <span class="location-error" id="sessionLocationError" style="display: none">${ui.message("referenceapplication.login.error.locationRequired")}</span>
                    </div>
                    <ul id="sessionLocation" class="select list-group">
                        <% locations.sort { ui.format(it) }.each { %>
                        <li id="${ui.encodeHtml(it.name)}" tabindex="0" class="list-group-item small col-sm-6 col-md-4 col-lg-3" value="${it.id}">${ui.encodeHtmlContent(ui.format(it))}</li>
                        <% } %>
                        <div class="clearfix"></div>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <input type="hidden" id="sessionLocationInput" name="sessionLocation"
                    <% if (lastSessionLocation != null) { %> value="${lastSessionLocation.id}" <% } %> />

                <div class="float-right">
                    <input id="loginButton" class="btn btn-success" type="submit" value="${ ui.message("referenceapplication.login.button") }"/>
                    <div>
                    <a id="cantLogin" href="javascript:void(0)">
                        <i class="icon-question-sign small"></i>
                        ${ ui.message("referenceapplication.login.cannotLogin") }
                    </a>
                    </div>
            </div>
            </fieldset>

    		<input type="hidden" name="redirectUrl" value="${redirectUrl}" />

        </form>

    </div>
</div>

<div id="cannotLoginPopup" class="dialog modal-content" style="display: none">
    <div class="modal-header">
        <i class="icon-info-sign"></i>
        <div>${ ui.message("referenceapplication.login.cannotLogin") }</div>
    </div>
    <div class="modal-body">
        <i>${ ui.message("referenceapplication.login.cannotLoginInstructions") }</i>
        <br/><br/>
        <button class="btn confirm btn-success">${ ui.message("referenceapplication.okay") }</button>
    </div>
</div>

</body>
</html>
