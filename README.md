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

# Run
Run main.m
```
main('data/train', 'data/test')
```

To save/load a training file so it doesn't have to process the entire training set again:
```
main('data/train', 'data/test', 'trained_model.mat')
```
