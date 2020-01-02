STATUS=$(curl -s "http://sonarqube.localhost:9000/api/qualitygates/project_status?projectKey=sas_judo" | ./jq -r .projectStatus.status)

if [ $STATUS = "ERROR" ]
then
  echo "Qualitygate failed. ${STATUS}"
  exit 1
fi

echo "Sonar Qualitygate is OK. ${STATUS}"
exit 0