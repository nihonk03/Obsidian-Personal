Stop-ScheduledTask -TaskName "TunelDVR_Granada"

Start-ScheduledTask -TaskName "TunelDVR_Granada"

python3 /tmp/patch_snapshot.py && systemctl restart hikvision-snapshot

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhtesYyu+6SctsqEDKJNa8PcDwuC3hqBqToHt5cbXX/ sucursal_lascolinas

ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -R 0.0.0.0:9581:192.168.1.110:554 root@198.211.97.243 -N