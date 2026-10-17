Invoke-RestMethod -Method Post -Uri http://localhost:8181/management/v1/bootstrap -ContentType 'application/json' -Body '{"accept-terms-of-use": true}'
foreach ($w in 'bronze','silver','gold') {
  $body = @{
    'warehouse-name' = $w
    'storage-profile' = @{ type='s3'; bucket=$w; 'key-prefix'=''; endpoint='http://host.docker.internal:9000';
                           region='us-east-1'; 'path-style-access'=$true; flavor='s3-compat'; 'sts-enabled'=$false }
    'storage-credential' = @{ type='s3'; 'credential-type'='access-key'; 'aws-access-key-id'='minioadmin'; 'aws-secret-access-key'='minioadmin' }
  } | ConvertTo-Json -Depth 5
  Invoke-RestMethod -Method Post -Uri http://localhost:8181/management/v1/warehouse -ContentType 'application/json' -Body $body
}
