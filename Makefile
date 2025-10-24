#update_core:
#	cd uifd && go build -o aa ./update && ./aa && rm ./aa

release:
	NODE_OPTIONS="--openssl-legacy-provider" npm run build:stage
	cp -R ./dist/ ./uifd/web_dist/
	cd uifd/service/ &&	goreleaser --snapshot --clean
	cd uifd && go build -o build.exe ./build_service && ./build.exe \
	&& GITHUB_TOKEN=disabled goreleaser --snapshot --skip=validate
#	cd ..
# 	echo "ui4freedom.org" >> ./dist/CNAME
	mkdir ./dist/releases/
	cp ./uifd/dist/uif-* ./dist/releases/
	cp ./uifd/dist/uif-* ./doc/static/assets/release/
	cp ./uifd/ui4freedom* ./doc/static/assets/release/
	cp ./uifd/uiforfreedom* ./doc/static/assets/release/
	cp ./uifd/linux_install.sh ./doc/static/assets/release/
	cp ./uifd/version/* ./doc/static/assets/release/version

clean:
	rm -rf ./dist/
	rm -rf ./uifd/dist/
	rm -rf ./uifd/uifd_dist/
	rm -rf ./uifd/web_dist/
	rm -rf ./uifd/webs_dist/
	rm -rf ./uifd/service/dist/
	rm -f ./uifd/build.exe
#	rm -rf ./doc/static/assets/release/
