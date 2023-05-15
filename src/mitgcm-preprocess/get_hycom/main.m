clearvars -except input_json_file tool_root;
close all
clc

input_json = read_json(input_json_file);
opath = input_json.hycom.rawdata_dir;
OpenDAP_URL = 'http://tds.hycom.org/thredds/dodsC/GLBv0.08/expt_93.0';

f0 = 21; % ????????????????????

start_date = input_json.hycom.start_date;
end_date   = input_json.hycom.end_date;


fprintf('Output directory: %s\n', opath);
fprintf('start_date : %s\n', start_date);
fprintf('end_date   : %s\n', end_date);

mkdir(opath);

% Boundaries for all dates
regions = {'north', 'east', 'south', 'west'};
for i = 1:length(regions)
    region = regions{i};
    display(['Grabbing boundary data of region: ' region]);
    getHycomData(start_date, end_date, region, opath, OpenDAP_URL, f0);
end 

% Initial condition for the first date
display(['Grabbing initial condition data']);
getHycomData(start_date, start_date, 'all', opath, OpenDAP_URL, f0);


display(['Download data finished.'])


