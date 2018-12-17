#!/usr/bin/env bash

MYSQL=$1

if [ -z "$MYSQL" ]
then
    echo "Syntax: $0 mysql_connection "
    echo "Where 'mysql_connection is your client invocation"
    echo "Examples:"
    echo "      mysql # (when using \$HOME/.my.cnf)"
    echo "      'mysql -u something -psomepass -P3307'"
    echo "      'mysql --defaults-file=/some/path/my.cnf'"
    echo "      \$HOME/sandboxes/msb_5_7_9/use"
    echo ""
    exit 1
fi

EXPECTED=(
city:4079
country:239
countrylanguage:984
)

function get_expected
{
    table=$1
    field=$2
    for E in ${EXPECTED[*]}
    do
        t=$(echo $E | tr ':' ' ' | awk '{print $1}')
        count=$(echo $E | tr ':' ' ' | awk '{print $2}')
        
        if [ "$t" == "$table" ]
        then
           if [ "$field" == "count" ]
           then
               echo $count
           fi 
           return
        fi
    done
}

printf "%-15s %-10s      \n" table count
echo '--------------- ----------     '
for T in $($MYSQL -BN -e 'show tables from world') 
do 
    COUNT=$($MYSQL -BN -e "select count(*) from $T" world)
    expected_count=$(get_expected $T count)
    if [ "$expected_count" == "$COUNT" ]
    then
        COUNT_RESULT=OK
    else
        COUNT_RESULT=DIFFERS
    fi

    printf "%-15s %'10d      (%-7s)\n" $T $COUNT  $COUNT_RESULT
done
