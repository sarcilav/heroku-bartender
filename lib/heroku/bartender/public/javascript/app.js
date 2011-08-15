$(function(){
    $(".build img")
});
var deploy = function(sha){
    $.post("", { 'sha': sha}, function(){
        window.location.reload();
    });
};
var isDeploying = function(){
    $.get("/status",function(data){
        alert(data["deploying"]);
    });
}
