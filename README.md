# Wavelet-Classification


# Run
Run main.m
```
main('data/train', 'data/test', 'mfcc', 'svm', 'mfcc_model.mat')
```
```
main('data/train', 'data/test', 'scattering', 'svm', 'scattering_model.mat')
```
```
main('data/train', 'data/test', 'scattering2', 'svm', 'scattering2_model.mat')
```

# Setup
To extract relevant files from MedleyDB:
```
python/extract_instrument_stems.py --destination './data/train' --min_sources 10
```
or
```
python/extract_instrument_stems.py -d './data/train' -i 'piano' 'clean electric guitar' 'cello'
```

Create the training set by putting .wav files under similarly named subdirectories in .data/test
To create a testing set by removing files from the training set use:
```
python/create_test_set.py -s './data/train' -d './data/test' -l random -n 1
```

To reduce the training set and ensure the same total duration (in seconds) for each instrument:
```
python/trim_audio.py -s ./data/train/ -l 300
```
