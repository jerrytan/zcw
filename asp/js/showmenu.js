function findObj(theObj, theDoc)
{
	var p, i, foundObj;
  
  	if(!theDoc) 
		theDoc = document;
  	if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  	{
    	theDoc = parent.frames[theObj.substring(p+1)].document;
    	theObj = theObj.substring(0,p);
  	}
  		if(!(foundObj = theDoc[theObj]) && theDoc.all) 
			foundObj = theDoc.all[theObj];
  		for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    		foundObj = theDoc.forms[i][theObj];
  	for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    	foundObj = findObj(theObj,theDoc.layers[i].document);
  	if(!foundObj && document.getElementById) 
		foundObj = document.getElementById(theObj); 
  	return foundObj;
}

function ShowHide(ObjectId)
{
	var tarimg1;

	tarimg1=document.getElementById(ObjectId+"_img1");
	with(findObj(ObjectId))
	{
    	if(style.display=='none')
		{
        	style.display='';     
		     		
			if (ObjectId=="51windows")
		 		tarimg1.src='../images/Lminus.gif'
		 	else
		  		tarimg1.src='../images/Lminus.gif'
			}
         else
         {
		 	style.display='none';
		  	if (ObjectId=="51windows")
		 		tarimg1.src='../images/Lplus.gif'
		 else
		  	tarimg1.src='../images/Lplus.gif'
		 }
  	}
}


function ShowHide_2(ObjectId)
{
	var tarimg1;

	tarimg1=document.getElementById(ObjectId+"_img2");
  	with(findObj(ObjectId))
  	{
    	if(style.display=='none')
		{
         	style.display='';     		     
		
			if (ObjectId=="51windows")
		 		tarimg1.src='../images/web_biao4.gif'
			else
		  		tarimg1.src='../images/web_biao4.gif'
		}
      	else
        {
		 	style.display='none';
		  	if (ObjectId=="51windows")
		 		tarimg1.src='../images/web_biao3.gif'
		 	else
		 		tarimg1.src='../images/web_biao3.gif'
		 }
  	}
}
	
function showsubmenu(Objid)
{
	try
	{
		var whichEl = document.getElementById(Objid);
		if (whichEl.style.display == "none")
		{
			for( i=1;i<=7;i++)
			{
				whichEl = document.getElementById(Objid);

				if(whichEl.style.display == "")
				{
					document.getElementById(Objid).style.display="none";
					
				}
			}
			document.getElementById(Objid).style.display="";
		}
		else
		{
			document.getElementById(Objid).style.display="none";
		}

	}
	catch(e)
	{}
}
