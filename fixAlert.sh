#!/bin/bash
#
# fixAlert.sh
#
# List and Fix Hyperic Alerts
# Created function genAlertList, listAlertId, and fixAlert by Tepnimit Lakkanapantip - 12/07/18

HQAPI_HOME="/app/hyperic/hqapi1-client-6.0.4/bin"
TODAY=`date +%m%d%y%H%M%S`
ALERT_LIST="$HQAPI_HOME/ALERT_LIST/alertList.$TODAY.xml"

cd $HQAPI_HOME
mkdir -p $HQAPI_HOME/ALERT_LIST

genAlertList()
{
  $HQAPI_HOME/hqapi.sh alert list --notFixed
}

listAlertId()
{
  grep "Alert\ id" $ALERT_LIST | cut -d'"' -f2
}

fixAlert()
{
  declare -i al_id
  for al_id in $idlist
  do
	$HQAPI_HOME/hqapi.sh alert fix --id=$al_id --reason="Automate Expiring Hyperic Alerts - $TODAY"
  done
}

genAlertList > $ALERT_LIST
idlist=$( listAlertId )
fixAlert

