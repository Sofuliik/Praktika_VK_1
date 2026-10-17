docker run -d --name lakehouse-minio -p 9000:9000 -p 9001:9001 -e MINIO_ROOT_USER=minioadmin -e MINIO_ROOT_PASSWORD=minioadmin -v minio-data:/data quay.io/minio/minio:latest server /data --console-address ":9001"
docker run -d --name lakehouse-pg -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v pg-data:/var/lib/postgresql/data postgres:17
Start-Sleep -Seconds 10
docker run --rm -e "LAKEKEEPER__PG_ENCRYPTION_KEY=This-is-NOT-Secure!" -e "LAKEKEEPER__PG_DATABASE_URL_READ=postgresql://postgres:postgres@host.docker.internal:5432/postgres" -e "LAKEKEEPER__PG_DATABASE_URL_WRITE=postgresql://postgres:postgres@host.docker.internal:5432/postgres" quay.io/lakekeeper/catalog:latest-main migrate
docker run -d --name lakekeeper -e "LAKEKEEPER__PG_ENCRYPTION_KEY=This-is-NOT-Secure!" -e "LAKEKEEPER__PG_DATABASE_URL_READ=postgresql://postgres:postgres@host.docker.internal:5432/postgres" -e "LAKEKEEPER__PG_DATABASE_URL_WRITE=postgresql://postgres:postgres@host.docker.internal:5432/postgres" -p 8181:8181 quay.io/lakekeeper/catalog:latest-main serve
docker run -d --name trino -p 8080:8080 -v "${PWD}\catalog:/etc/trino/catalog" trinodb/trino:476
docker ps
# Дальше: создать buckets bronze/silver/gold в MinIO Console (http://localhost:9001, minioadmin/minioadmin),
# затем зарегистрировать warehouses в Lakekeeper: powershell scripts/create_warehouses.ps1
