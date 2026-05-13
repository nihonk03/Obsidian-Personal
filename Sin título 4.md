Stop-ScheduledTask -TaskName "TunelDVR_Granada"

Start-ScheduledTask -TaskName "TunelDVR_Granada"

python3 /tmp/patch_snapshot.py && systemctl restart hikvision-snapshot