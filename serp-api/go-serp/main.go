package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"strings"

	g "github.com/serpapi/google-search-results-golang"
)

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

func main() {
	apiKey := os.Getenv("SERPAPI_KEY")
	if apiKey == "" {
		fmt.Fprintln(os.Stderr, "error: SERPAPI_KEY environment variable is not set")
		os.Exit(1)
	}

	// Query priority: CLI args > SEARCH_QUERY env var > default
	var query string
	if len(os.Args) > 1 {
		query = strings.Join(os.Args[1:], " ")
	} else {
		query = getEnv("SEARCH_QUERY", "latest Kubernetes releases")
	}

	engine := getEnv("SEARCH_ENGINE", "google")
	numResults, err := strconv.Atoi(getEnv("NUM_RESULTS", "5"))
	if err != nil || numResults < 1 {
		numResults = 5
	}

	fmt.Printf("Query  : %s\n", query)
	fmt.Printf("Engine : %s\n", engine)
	fmt.Println(strings.Repeat("-", 60))

	params := map[string]string{
		"q":      query,
		"engine": engine,
	}

	search := g.NewGoogleSearch(params, apiKey)
	results, err := search.GetJSON()
	if err != nil {
		fmt.Fprintf(os.Stderr, "search error: %v\n", err)
		os.Exit(1)
	}

	// Dump full JSON when DEBUG=1
	if os.Getenv("DEBUG") == "1" {
		enc := json.NewEncoder(os.Stdout)
		enc.SetIndent("", "  ")
		_ = enc.Encode(results)
		return
	}

	// Extract organic results
	organic, ok := results["organic_results"].([]interface{})
	if !ok {
		fmt.Println("No organic results found.")
		return
	}

	shown := numResults
	if shown > len(organic) {
		shown = len(organic)
	}
	fmt.Printf("Found %d organic results (showing top %d)\n\n", len(organic), shown)

	for i, item := range organic[:shown] {
		r, ok := item.(map[string]interface{})
		if !ok {
			continue
		}
		title, _ := r["title"].(string)
		link, _ := r["link"].(string)
		snippet, _ := r["snippet"].(string)

		if len(snippet) > 160 {
			snippet = snippet[:160]
		}

		fmt.Printf("%d. %s\n", i+1, title)
		fmt.Printf("   %s\n", link)
		fmt.Printf("   %s\n\n", snippet)
	}
}
