package client

import (
    "os"
    "github.com/iamthemuffinman/logsip"
)

var logger = logsip.New(os.Stdout)
//recursively search directories for matching media files
func ScanDirectory (string dir) map[string][]int {
    if _, err := os.Stat(dir); err != nil {
        
    } else {
    logger.ERROR(dir, "does not exist")
    }
}

func MatchMediaFile(string dir) {

}
