
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
        # name_frame[name_frame$Id %in% sub$Id,]["ROC"] <<- ROC(sub$Count)
        sub$ROC = ROC(sub$Count)
        return (sub)
    })
    stopCluster(clus)
    
    #name_frame = rbind.fill.parallel(sub_list)
    
    return (rbind_all(sub_list))
}
Sys.time()
roc_names = parallel_roc(names)
Sys.time()
write.csv(roc_names,file="roc_data.csv",row.names=TRUE)


require("TTR")
require("parallel")
require("dplyr")


roc_data = read.csv(file = "~/roc_data.csv",header = TRUE)
pairs = unique(roc_data[c("Year","Gender")]) # easy way to do something for every year/gender
roc_data$ROC[which(is.na(roc_data$ROC))] = 0; # Just go away please



clus = makeCluster(45)

clusterExport(cl=clus,varlist=list("pairs","roc_data"),envir=environment())

results = parRapply(clus,pairs,function(x){    
    sub = subset(roc_data,Year==x[1] & Gender == x[2])
    return (rbind(sub[which(sub$ROC == max(sub$ROC)),],sub[which(sub$ROC == min(sub$ROC)),]))
})
stopCluster(clus)



results = rbind_all(results)

write.csv(results,file="~/extrema.csv",row.names=TRUE)


