clc;clear;close all;

path = '/Users/chris/data/OTB/';
dr = dir(path);
dr = dr(3:end);

for i = 1:length(dr)
    titles{i} = dr(i).name;
end

for i = 1:length(titles)
    clc; clearvars -except i titles path; close all;
    title = titles{i};
    if exist([path title],'dir')
        track(title);
    end
end
