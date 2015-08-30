%% reshape the feats4096*10000 to feat 10000*4096
feat=zeros(10000,4096);
tic
for i=1:10000
    feat(i,:)=feats(:,i);
end
toc