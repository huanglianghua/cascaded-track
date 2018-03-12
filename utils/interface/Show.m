function opt = Show(frame, bbox, opt, t)

if isfield(opt,'doshow')
    if opt.doshow == 0; return; end
    if opt.doshow == 1
        set(gcf,'visible','off');
    end
end

corners = ToCorners(bbox, opt.tsize);

% show

if ~isfield(opt,'handle_img')
    opt.handle_img = imshow(frame);
    opt.handle_line = line(corners(1,:), corners(2,:), 'Color', 'y', 'LineWidth', 2);
else
    set(opt.handle_img, 'CData', frame);
    set(opt.handle_line, 'XData', corners(1,:));
    set(opt.handle_line, 'YData', corners(2,:));
end
drawnow;

% save

if isfield(opt,'dosave') && opt.dosave == 2
    path = [opt.savePath 'frames/' opt.title '/'];
    if ~exist(path,'dir'); mkdir(path); end
    saveas(gca, [path '/' opt.imFiles(t).name]);
end

end


function corners = ToCorners(bbox, tsz)

if length(bbox) == 4
    bbox = ToAffine(bbox, tsz);
end

w = tsz(1); h = tsz(2);
corners0 = [ 1,-w/2,-h/2; 1,w/2,-h/2; 1,w/2,h/2; 1,-w/2,h/2; 1,-w/2,-h/2 ]';

p = affparam2mat(bbox);
M = [p(1) p(3) p(4); p(2) p(5) p(6)];
corners = M * corners0;

end

function affine = ToAffine(rect, tsz)

x = rect(1) + (rect(3) - 1) / 2;
y = rect(2) + (rect(4) - 1) / 2;
w = rect(3);
h = rect(4);

affine = [x y w/tsz(1) 0 h/w 0];

end