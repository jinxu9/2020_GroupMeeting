setwd("C:/Users/miao/Desktop/R�γ���ҵ")
sample_inform <- read.table("sample_inform.txt",sep="\t",header=TRUE)
gene_data <- read.table("RNAseq_hg19_refGene_counts.txt",sep="\t",header=FALSE, row.names=1)
gene_data2 <- subset(gene_data, rowSums(gene_data) >= 910)


mer_data <- cbind(sample_inform, t(gene_data2))
no_na <- mer_data[complete.cases(mer_data$Age),]
age_na <- mer_data[!complete.cases(mer_data$Age),]

sample_inform_nona <- no_na[, 1:3]
gene_data_nona <- t(no_na[, 4:ncol(no_na)])
sample_inform_na <- age_na[, 1:3]
sample_inform_na #�õ���ID���ǰ�˳�򡣡���
gene_data_na <- t(age_na[, 4:ncol(age_na)])

# ����tidyverse��purrrlyr����
library(tidyverse)
library(purrrlyr)

# ����ÿһ�еĺ���row_handler
row_handler <- function(row.data){  
  index <- which(row.data == min(row.data))  #  �ҳ���С��Ԫ�ص�index
  out <- names(row.data[index]) %>% #  ��index��ԭ������
    str_c(collapse = "\t") # ƴ��
  return(out)
}


xlist <- list()
for(i in seq_len(ncol(gene_data_na))) { #��ÿһ������ȱʧ�������з���
  mati <- (gene_data_nona-gene_data_na[i])^2 #
  listi <- list(apply(mati, 1, row_handler))
  write.table(listi,format(i),row.name=F, sep="\t", quote=F)
}

#�б���python3�������õ�ÿ��ȱʧ����������ӽ�����������

na_list <- read.table("0003.txt",sep="\n",header=FALSE)
sample_inform3 <- t(sample_inform)
colnames(sample_inform3) <- colnames(gene_data2) #
for(i in seq_len(nrow(na_list))) {
  na_list[i,2] <- sample_inform3[2, na_list[i, 1]]
}
write.table(na_list, "1.txt", row.name=F, sep="\t", quote=F)
xlist <- t(na_list)
xlist <- rbind(t(sample_inform_na), xlist[2,])
write.table(xlist, "1.txt", row.name=T, col.name=F, sep="\t", quote=F)

