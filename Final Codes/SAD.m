function sad=SAD(CurrentBlk,ReferenceBlk)

sad1=sum(abs(CurrentBlk-ReferenceBlk));
sad=sum(sad1);

end