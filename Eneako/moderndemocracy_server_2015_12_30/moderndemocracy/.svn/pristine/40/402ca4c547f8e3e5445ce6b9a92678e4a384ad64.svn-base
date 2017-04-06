echo "-------------------------";
echo "Rebuilding DB...";
echo "-------------------------";

sh ./src/scripts/create_schema.sh;
sh ./src/scripts/load_base_data.sh;
sh ./tests/scripts/load-test-data.sh;


echo "-------------------------";
echo "Rebuilding DB... errors:";
echo "-------------------------";

cat /tmp/create_schema.log | grep -i error;

echo "";

echo "-------------------------";
echo "Loading test data... errors:";
echo "-------------------------";

cat /tmp/load-test-data.log | grep -i error;

echo "";

echo "-------------------------";
echo "Loading base data... errors:";
echo "-------------------------";

cat /tmp/load-base-data.log | grep -i error;

echo "";


echo "-------------------------"
echo "Rebuilding server:"
echo "-------------------------"

ant;

echo "-------------------------"
echo "Restarting server:"
echo "-------------------------"

sh ./src/init.d/daemon restart;
