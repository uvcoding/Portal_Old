<html>
<head>
<script type="text/javascript">
cc=0;
function changeimage()
{
if (cc==0) 
  {
  cc=1;
  document.getElementById('myimage').src="bulbon.gif";
  }
else
  {
  cc=0;
  document.getElementById('myimage').src="bulboff.gif";
  }
}
</script>
</head>

<body>

<img id="myimage" onclick="changeimage()" border="0" src="bulboff.gif" width="100" height="180" />
<p>Click to turn on/off the light</p>

</body>
</html>
