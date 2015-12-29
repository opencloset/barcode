#!/usr/bin/env perl

use Mojolicious::Lite;

app->defaults(
    %{ plugin 'Config' => {
            default => {
                project_name => q{},
                copyright    => q{},
                page_id      => q{},
            }
        }
    }
);

plugin "bootstrap3" =>
    { theme => { paper => "https://bootswatch.com/paper/_bootswatch.scss", } };

get "/" => "index";

app->start;

__DATA__
@@ index.html.ep
% layout 'default', page_id => 'home';
% title 'Home';
      <!-- home -->
      <div class="row">
        <div class="col-md-8">
          <div class="space-20"></div>
          <h2>의류 코드 변환기</h2>
          <div class="space-20"></div>

          <form class="bs-component">

            <div class="form-group">
              <label class="control-label">바코드를 입력하세요.</label>
              <div class="input-group">
                <input type="text" class="form-control" name="srcCode" id="srcCode">
                <span class="input-group-btn">
                  <button class="btn btn-primary btn-lg" type="button" id="btnConvert">변환</button>
                </span>
              </div>
            </div>

            <div class="space-20"></div>

            <div class="form-group">
              <label class="control-label" for="destCode">변환된 십진 코드</label>
              <input class="form-control" id="destCode" type="text" disabled="" name="destCode" id="destCode">
            </div>

          </form>

        </div>
      </div>

      <script type="text/javascript">
        $(function() {
          convertCodeToDecimal = function(c) {
            var result;
            switch (c) {
              case "0": result = "00"; break;
              case "1": result = "01"; break;
              case "2": result = "02"; break;
              case "3": result = "03"; break;
              case "4": result = "04"; break;
              case "5": result = "05"; break;
              case "6": result = "06"; break;
              case "7": result = "07"; break;
              case "8": result = "08"; break;
              case "9": result = "09"; break;
              case "A": result = "10"; break;
              case "B": result = "11"; break;
              case "C": result = "12"; break;
              case "D": result = "13"; break;
              case "E": result = "14"; break;
              case "F": result = "15"; break;
              case "G": result = "16"; break;
              case "H": result = "17"; break;
              case "I": result = "18"; break;
              case "J": result = "19"; break;
              case "K": result = "20"; break;
              case "L": result = "21"; break;
              case "M": result = "22"; break;
              case "N": result = "23"; break;
              case "O": result = "24"; break;
              case "P": result = "25"; break;
              case "Q": result = "26"; break;
              case "R": result = "27"; break;
              case "S": result = "28"; break;
              case "T": result = "29"; break;
              case "U": result = "30"; break;
              case "V": result = "31"; break;
              case "W": result = "32"; break;
              case "X": result = "33"; break;
              case "Y": result = "34"; break;
              case "Z": result = "35"; break;
            }
            return result;
          };

          $("#srcCode").focus();

          $("#srcCode").keypress(function(e) {
            if (e.keyCode === 13) {
              return $("#btnConvert").click();
            }
          });

          $("#btnConvert").click(function(e) {
            e.preventDefault();

            srcCode = $("#srcCode").val().toUpperCase();
            $("#srcCode").val(srcCode);

            if ( !/^[0-9A-Z]{4}$/.test(srcCode) ) {
              $("#destCode").val("유효하지 않은 바코드입니다.");
              $("#srcCode").select().focus();
              return;
            }

            codes = srcCode.split("");
            for ( var i = 0, len = codes.length; i < len; i++) {
              codes[i] = convertCodeToDecimal( codes[i] );
            }
            destCode = codes[0] + codes[1] + " - " + codes[2] + codes[3];
            $("#destCode").val(destCode);

            $("#srcCode").select().focus();
          });
        });
      </script>


@@ layouts/default.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
 
    <!-- Bootstrap + Bootswatch -->
    %= asset "paper.css"
    %= asset "bootstrap.js"
 
    <title><%= title %> - <%= $project_name %></title>
 
    <style>
      /* Move down content because we have a fixed navbar that is 50px tall */
      body {
        padding-top: 50px;
        padding-bottom: 20px;
      }

      /* spacer */
      .space-20 {
          margin: 20px 0 19px;
          max-height: 1px;
          min-height: 1px;
          overflow: hidden;
      }

      /* home */
      #home .form-group label {
        font-size: 2em;
      }
      #home input.form-control {
        font-size: 5em;
        height: 90px;
      }
      #home .btn-lg, #home .btn-group-lg > .btn {
          font-size: 48px;
          padding: 10px 40px;
      }
      #home input#srcCode {
          ime-mode:disabled;
      }
    </style>
  </head>
 
  <body>
 
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><%= $project_name %></a>
        </div>
      </div>
    </nav>
 
    <div <%== $page_id ? qq{id="$page_id"} : q{} %> class="container">
      <!-- PAGE CONTENT BEGINS -->
      <%= content %>
      <!-- PAGE CONTENT ENDS -->
 
      <hr>
 
      <footer>
        <p>&copy; <%= $copyright %></p>
      </footer>
    </div> <!-- /container -->
 
  </body>
</html>
