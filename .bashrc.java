# Switches between Java SE 6 and 7
toggle_jvm()
{
    current=$(echo $JAVA_HOME | sed "s/^.*\([0-9]\.[0-9]\.[0-9]\).*$/\1/g")

    echo "$current"
    case $current in
        1.7.0)
            export JAVA_HOME=$(/usr/libexec/java_home -v "1.8*")
            ;;
        1.8.0)
            export JAVA_HOME=$(/usr/libexec/java_home -v "1.7*")
            ;;
        *)
            echo "Java version detected [$current], reverting to 1.8*"
            export JAVA_HOME=$(/usr/libexec/java_home -v "1.8*")
            ;;
    esac
}
