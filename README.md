# Protein Domain Identifier

**Protein Domain Identifier** is a command-line Perl tool designed to analyze protein sequences in FASTA format and identify common functional domains such as Zinc Finger, Kinase, and Helix-turn-Helix motifs. Using BioPerl for sequence parsing and regex-based pattern matching, this tool provides a lightweight, flexible solution for researchers and bioinformaticians to quickly scan protein datasets without the need for complex web applications.

## Key Features

- Parses protein sequences from FASTA files using BioPerl.
- Detects multiple protein domains through customizable regular expressions.
- Supports output in multiple formats: plain text, CSV, and JSON.
- Command-line interface with options for input file, output file, output format, and verbosity.
- Modular design enabling easy extension with additional domain patterns or integration with domain databases.
- Suitable for batch processing large protein datasets.
- Generates structured output for downstream analysis or reporting.

## Getting Started

This repository includes:

- `bin/domain_identifier.pl`: Main executable Perl script.
- `lib/ProteinDomainIdentifier.pm`: Core module implementing domain detection logic.
- `samples/example.fasta`: Example input file for testing.
- `README.md`: Documentation and usage instructions.

## Usage Example

```bash
perl bin/domain_identifier.pl --input samples/example.fasta --format csv --verbose
```

This command scans the example FASTA file, identifies protein domains, and outputs the results in CSV format with progress messages.

## Why Use This Tool?

This tool offers a simple yet powerful way to identify protein domains locally without relying on web servers or external databases. It is ideal for quick prototyping, educational purposes, or integration into larger bioinformatics pipelines.

---

This description clearly communicates the purpose, features, and usage of your project, helping others understand its value and how to get started. You can place this text in your repository’s `README.md` or GitHub’s repository description field.

[1] https://coderefinery.github.io/github-without-command-line/creating-using-desktop/
[2] https://docs.github.com/en/desktop/overview/creating-your-first-repository-using-github-desktop
[3] https://www.youtube.com/watch?v=JBW6-5_RhUU
[4] https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-a-repository-from-your-local-computer-to-github-desktop
[5] https://www.codecademy.com/article/what-is-git-and-github-desktop
[6] https://docs.github.com/en/repositories/creating-and-managing-repositories/quickstart-for-repositories
[7] https://docs.github.com/en/desktop/overview/getting-started-with-github-desktop
[8] https://www.youtube.com/watch?v=no9MJOwN_mE
