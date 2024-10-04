#include <iostream>
#include <vector>
using namespace std;

int main(){
	int n;
	cout << "Enter N: ";
	cin >> n;
	vector<int> arr(n,0);
	cout << "Enter N numbers: ";
	for (int i = 0; i < n; i++){
		cin >> arr[i];
	}
	int k;
	cout << "Enter k: ";
	cin >> k;
	for (int i = k; i < n; i++){
		arr[i-1]=arr[i];	
	}	
	arr.pop_back();
	cout << "Result array:" << endl;
	for (int i = 0; i < n-1; i++){
		cout << arr[i] << " ";
	}
	cout << "\n";
	return 0;
}

