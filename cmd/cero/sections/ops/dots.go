// package ops

package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

var root = "/data/Personal/lar"
var _, home = os.UserHomeDir()

func main() {
	linking(getFiles())
}

func getFiles() []string {
	var files []string

	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if shouldIgnore(path) {
			return nil
		}

		files = append(files, path)

		return nil
	})

	if err != nil {
		panic(err)
	}

	return files
}

func linking(files []string) {
	for _, file := range files {
		fmt.Println(file)
	}
}

func shouldIgnore(path string) bool {
	ignoreItems := []string{"LICENSE", ".git", ".log"}

	for _, ignore := range ignoreItems {
		x := filepath.Join(root, ignore)

		if strings.HasPrefix(path, x) {
			return true
		}
	}

	return false
}

func toHome() {}
func backupThisOne() {}
func createHomeFolder() {}
func SymlinkTheseOnes() {}
