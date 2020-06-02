function ssd=SSD(CurrentBlk,ReferenceBlk)

ssd1=sum((abs(CurrentBlk-ReferenceBlk)).^2);
ssd=sum(ssd1);

end