
var deploy = function(sha){
    $.post("", { 'sha': sha}, function(){
        isDeploying();
    });
};

var putOverlay = function(){
    $("#deploying").overlay().load();
};

var isDeploying = function(){
    var deploying = false;
    $.get("/status",function(data){
        deploying = data["deploying"];
        if(deploying == true){
            putOverlay();
        }
    });
    setTimeout("window.location.reload()", 30000);
};

$(function(){
    $(".build img");
    $("#deploying").overlay({
        top: 260,
        mask: {
            color: '#fff',
            loadSpeed: 200,
            opacity: 0.5
        },
        closeOnClick: false,
        load: false
    });
    isDeploying(); 
});
