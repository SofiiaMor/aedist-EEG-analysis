% script to run AMICA for one subject with epoched data

% define parameters
num_models = 1;     % # of models of mixture ICA
max_iter = 2000;    % max number of learning steps
dataRank = EEG.nbchan - length(find(~EEG.etc.clean_channel_mask)); % datarank = decreased by the number of rejected channels

% run amica 
outdir = 'E:\CIIRK\new_data\EEG_data\pre-processed_data\different_attempts_optimizing_pipeline\another_option\ag20200131\amicaout';
runamica15(EEG.data, 'num_models',num_models, 'num_chans', EEG.nbchan, 'outdir', outdir, ...
    'pcakeep', dataRank, 'max_iter',max_iter, 'do_reject', 1, 'numrej', 15, 'rejsig', 3, 'rejint', 1);
EEG.etc.amica  = loadmodout15(outdir);
EEG.etc.amica.S = EEG.etc.amica.S(1:EEG.etc.amica.num_pcs, :); % Weirdly, I saw size(S,1) be larger than rank. This process does not hurt anyway.
EEG.icaweights = EEG.etc.amica.W;
EEG.icasphere  = EEG.etc.amica.S;

% pop_topoplot(EEG, 0, [1:50] ,'EEG Data epochs',[6 6] ,0,'electrodes','on');
% print('-djpeg', 'test_AMICA.jpg');
% pop_saveset(EEG, 'filename', 'as20200224_bad_epochs_rejected_AMICA.set');

%% ICA (runica) for one subject with epoched data 
dataRank = EEG.nbchan - length(find(~EEG.etc.clean_channel_mask)); % datarank = decreased by the number of rejected channels
EEG = pop_runica(EEG, 'icatype','runica','concatcond','on','options',{'extended', 1, 'pca', dataRank, 'stop', 1E-7});
eeglab redraw

EEG = pop_iclabel(EEG, 'default');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );

pop_topoplot(EEG, 0, [1:35] ,'scalp maps of ICs runica',[5 7] ,0,'iclabel','on');
print('-djpeg', 'as20200224_runica.jpg');