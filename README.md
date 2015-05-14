# Wavelet-Classification


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

# Run
Run main.m
```
main('data/train', 'data/test', 'scattering', 'svm')
```

To save/load a training file so it doesn't have to process the entire training set again:
```
main('data/train', 'data/test', 'mfcc', 'knn', 'mfcc_model.mat')
```
