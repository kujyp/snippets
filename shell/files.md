```bash
# filecount
# -U: unsort
ls -U | wc -l

for prefix in dir1 dir2 dir3; do
    time bash -c "ls -U ${prefix}_dev2/asr/audio | wc -l"
    time bash -c "ls ${prefix}_dev2/asr/audio | wc -l"
    echo ""
done

7180940
bash -c "ls -U ${prefix}_dev2/asr/audio | wc -l"  2.51s user 1.51s system 110% cpu 3.645 total
7180940
bash -c "ls ${prefix}_dev2/asr/audio | wc -l"  40.05s user 3.35s system 100% cpu 43.127 total

584135
bash -c "ls -U ${prefix}_dev2/asr/audio | wc -l"  0.18s user 0.11s system 109% cpu 0.272 total
584135
bash -c "ls ${prefix}_dev2/asr/audio | wc -l"  3.74s user 0.21s system 100% cpu 3.927 total

424387
bash -c "ls -U ${prefix}_dev2/asr/audio | wc -l"  0.17s user 0.08s system 110% cpu 0.229 total
424387
bash -c "ls ${prefix}_dev2/asr/audio | wc -l"  2.87s user 0.19s system 100% cpu 3.046 total


```
