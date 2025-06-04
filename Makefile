.PHONY: update
update:
	home-manager switch --flake .#davidemarcoli

.PHONY: cleanup
cleanup:
	nix-collect-garbage -d
