function bbox = Vote(bboxes, confidence, opt)

if ~opt.conf
    confidence = ones(size(bboxes,2),1) / size(bboxes,2);
end

switch lower(opt.vote)
case 'ds'
    w = DSCluster(bboxes(1:2,:), confidence);
    bbox = bboxes * w;
case 'med'
    bbox = Median(bboxes, confidence);
case 'ms'
    bbox = MeanShift(bboxes, confidence);
end

end
