function [bbox, opt] = config(title)

opt.title = title;

% path

basePath = '/Users/chris/data/OTB/';
opt.imPath = [basePath title '/img/'];
opt.imFiles = dir([opt.imPath '*.jpg']);

opt.savePath = './results/';

addpath(genpath('utils'));
addpath(genpath('dependency'));

% range

switch lower(title)
    case 'david'
        opt.range = 300:770;
    case 'football1'
        opt.range = 1:74;
    case 'freeman3'
        opt.range = 1:460;
    case 'freeman4'
        opt.range = 1:283;
    otherwise
        opt.range = 1:length(opt.imFiles);
end

% parameters

opt.featType = 'fhog';
opt.binsize = 4;

% sampler

opt.tsize = [32 32];

opttrain.nsample = 200;
opttrain.sigma = [10 10 0 0 0 0]';
opt.train = opttrain;

optdetect.nsample = 400;
optdetect.sigma = [20 20 0 0 0 0]';
opt.detect = optdetect;

% cascade

opt.T = 5;
opt.ncascade = 1;

% components

opt.vote = 'DS';    % 'DS' 'MED' 'MS'
opt.conf = 1;       % 0 1

% option

opt.doshow = 1;     % 0 1 2
opt.dosave = 2;     % 0 1 2

% init

annoPath = [basePath title '/groundtruth_rect.txt'];
anno = dlmread(annoPath);
rect = anno(1,:);

bbox = [rect(1:2)+(rect(3:4)-1)/2 rect(3)/opt.tsize(1) 0.0 rect(4)/rect(3) 0.0]';

end
