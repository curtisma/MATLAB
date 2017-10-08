function getSelectedVersion(){
	return versionSelector.options[versionSelector.selectedIndex];
}

function versionChanged(){
	newVersion = getSelectedVersion();
	newVersionName = newVersion.getAttribute("name");
	// Thumbnail
	currentThumbnail = toolboxThumbnail.firstElementChild ;
	newThumbnail = document.getElementById("thumbnailV"+newVersionName);
	hiddenContainer.appendChild(currentThumbnail);
	toolboxThumbnail.appendChild(newThumbnail);
	// Summary
	currentSummary = summaryContainer.firstElementChild ;
	newSummary = document.getElementById("summaryV"+newVersionName);
	hiddenContainer.appendChild(currentSummary);
	summaryContainer.appendChild(newSummary);
	// Description
	currentDescription = descriptionContainer.firstElementChild ;
	newDescription = document.getElementById("descriptionV"+newVersionName);
	hiddenContainer.appendChild(currentDescription);
	descriptionContainer.appendChild(newDescription);
}

function pingFromMatlab(){
	isMatlabBrowser = true;
}

function downloadToolbox(){
	if(isMatlabBrowser){
		window.location.href = "matlab: minimart.installToolbox('"+absolutePath("../"+getSelectedVersion().value)+"',false,false);";
	}else{
		window.location.href = "../"+getSelectedVersion().value;
	}
}

function initializeComponents(){
	hiddenContainer = document.getElementsByClassName("hiddenContainer")[0];
	toolboxThumbnail = document.getElementsByClassName("toolboxThumbnail")[0];
	versionSelector = document.getElementById("versionSelector");
	summaryContainer = document.getElementById("summaryContainer");
	descriptionContainer = document.getElementsByClassName("descriptionContainer")[0];
	// Ping maltab, if exist
	window.location.href = "matlab: minimart.Site.pingBrowser();";
}

function absolutePath(relativePath) {
    var link = document.createElement("a");
    link.href = relativePath;
    return (link.protocol+"//"+link.host+link.pathname+link.search+link.hash);
}

// For toolbox pages, will return undefined in the store (but won't be used)
var hiddenContainer;
var versionSelector;
var toolboxThumbnail;
var summaryContainer;
var descriptionContainer;

var isMatlabBrowser = false;

window.onload = initializeComponents;