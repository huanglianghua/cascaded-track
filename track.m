function bboxes = track(title)

bboxes = [];
[bbox, opt] = config(title);

for t = opt.range
    disp(['frame: ' num2str(t)]);
    
    frame = Load( [opt.imPath opt.imFiles(t).name] );

    if t == opt.range(1)
        model = Init(frame.gray, bbox, opt);
    else
        bbox = Locate(frame.gray, bbox, model, opt);
        model = Update(frame.gray, bbox, model, opt);
    end

    opt = Show(frame.origin, bbox, opt, t);
    bboxes = [bboxes bbox];
end

Save(bboxes, opt);

end
