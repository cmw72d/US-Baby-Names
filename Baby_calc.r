
require("TTR")
require("parallel")
require("dplyr")

names = read.table("~/NationalNames.csv",header = TRUE,sep=",")
names["ROC"] = NA


parallel_roc = function(name_frame) {
    
    pairs = unique(name_frame[c("Name","Gender")])

    clus = makeCluster(45)
    clusterExport(cl=clus,varlist=list("pairs","name_frame","ROC"),envir=environment())

    sub_list = parRapply(clus,pairs,function(x) {
        sub = subset(name_frame,Name==x[1] & Gender == x[2])
        sub$ROC = ROC(sub$Count)
        return (sub)
    })
    stopCluster(clus)
    
    return (rbind_all(sub_list))
}
Sys.time()
roc_names = parallel_roc(names)
Sys.time()
write.csv(roc_names,file="roc_data.csv",row.names=TRUE)
