function RenameImagePilotDicom

% RenameImagePilotDicom reads the patientID from the Dicom-file to rename
% the Dicom-file with patientID as filename.  This function will search
% for all Dicom files in the selected folders and subfolders.
% April 2017 ImagePilot doesn't add file extension to dicom files, what
% makes them difficult to seperate from other files, so select only folder
% with dicom files.

% Dicom-file folders, user input
dir = uigetdir(pwd,'Select folder with ImagePilot exports');
% Find all Dicom files in selected folders
currentFolder =pwd;
% Change search path to dicom folder
cd(dir)
[~,list]=system('dir /B /S ');
% Change path to script directory
cd(currentFolder);
files = strsplit(list, '\n');

%Select folder to save renamed dicom files, user input
SavePath = uigetdir(dir,'Select folder to save renamed Dicom-files');
if SavePath == 0
    disp('User selected cancel')
else
    % Get Dicom information, get x-ray image and save it.
    for iFile = 1:(numel(files)-1)
        source = char(files(iFile));
        if isdir(source)==0
            DicomInfo = dicominfo(source);
            destination = fullfile(SavePath,[DicomInfo.PatientID,'.dcm']);
            [status,message,messageid] = copyfile(source,destination);
            if status == 1
                disp(['Copied: ',destination]);
            else
                errordlg(['Error message ',message,' ID ',messageid],'Copy error!');
            end
        end
    end
end
end



