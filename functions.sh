## Bash functions to be included in my default developer workspace
function pushtag {
  checkup;
  git tag "$1";
  git push origin --tags;
}

function cleanup {
  rm $1/Snap.*
  rm $1/Core.*
  rm $1/javacore.*
  rm $1/core.*
  rm $1/heapdump.*
}
