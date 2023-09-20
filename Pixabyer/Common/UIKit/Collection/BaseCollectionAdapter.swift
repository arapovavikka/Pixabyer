//
//  BaseCollectionAdapter.swift
//  Pixabyer
//
//  Created by Vika on 07.09.2023.
//

import Foundation
import UIKit

class BaseCollectionAdapter<ViewModel>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
	public weak var collectionView: UICollectionView?
	public var viewModel: [ViewModel] = []

	let appearance = Appearance()

	open func connect(collectionView: UICollectionView) {
		self.collectionView = collectionView
		self.collectionView?.dataSource = self
		self.collectionView?.delegate = self
	}

	open func disconnect(tableView: UITableView) {
		collectionView?.dataSource = nil
		collectionView?.delegate = nil
		collectionView = nil
	}

	open func update(viewModel: [ViewModel]) {
		self.viewModel = viewModel
		collectionView?.reloadData()
	}

	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.count
	}

	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return BaseCollectionViewCell()
	}
	
	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}

	open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return collectionView.bounds.size
	}
	
	open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) { }
	
	open func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) { }

	open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { }
	
	open func dequeueCell<T: BaseCollectionViewCell>(for type: T.Type, index indexPath: IndexPath) -> T? {
		return collectionView?.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T
	}
}
