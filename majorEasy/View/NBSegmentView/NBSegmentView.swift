//
//  NBSegmentView.swift
//  NoteBook
//
//  Created by dede wang on 2019/10/20.
//  Copyright © 2019 com.boc. All rights reserved.
//

import UIKit
import RxSwift

let defaultItemWidth: CGFloat = 375 / 6 + 5

class NBSegmentView: UIView {

    /// item数组
    var titleArray: [String] = []{
        didSet{
            setupUI(titleArray: titleArray)
        }
    }
    
    /// 选中某一item事件命令
    var selectedItemCommand = PublishSubject<Int>()
    
    
    /// 记录选中的按钮
    var selectedItem: UIButton? {
        didSet{
            selectedItem?.titleLabel?.font = selectedFont
        }
    }
    
    /// 被选中item的位置
    var selectedIndex: Int = 0 {
        didSet{
            guard let button = getButton(selectedIndex: selectedIndex) else { return }
            updateButtonStatus(sender: button)
        }
    }
    
    /// 每个 item 宽度，默认 MosConstant.ScreenWidth / 6
    var itemWidth: CGFloat = defaultItemWidth {
        didSet{
            segmentLineWidth = itemWidth
            setupScrollViewContentSize()
        }
    }
    
    /// item 高度，默认35
    var itemHeight: CGFloat = 35 {
        didSet{
            layoutViews()
            layoutIfNeeded()
        }
    }
    
    /// 每个 item 之间的距离，默认0
    var horizonalSpacing: CGFloat = 0 {
        didSet{
            setupScrollViewContentSize()
        }
    }
    
    /// 底部可滑动蓝线的宽度
    var segmentLineWidth: CGFloat = defaultItemWidth {
        didSet{
            segmentLine.snp.updateConstraints { (make) in
                make.width.equalTo(segmentLineWidth)
            }
        }
    }
    
    /// 底部可滑动蓝线的高度，默认1
    var segmentLineHeight: CGFloat = 1 {
        didSet{
            segmentLine.snp.updateConstraints { (make) in
                make.height.equalTo(segmentLineHeight)
                make.top.equalToSuperview().offset(itemHeight - segmentLineHeight)
            }
        }
    }
    
    /// item 字体
    var itemFont: UIFont = PingFangRegular(14) {
        didSet{
            updateItemsFont(font: itemFont)
        }
    }
    
    /// item 被选中时的字体
    var selectedFont: UIFont = PingFangMedium(14) {
        didSet{
            selectedItem?.titleLabel?.font = selectedFont
        }
    }
    
    private var itemRect: CGRect {
        return  CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
    }
    
    //MARK: -
    convenience init(titleArray: [String]) {
        self.init(frame: CGRect.zero)
        self.titleArray = titleArray
        self.scrollView.isDirectionalLockEnabled = true
        setupUI(titleArray: titleArray)
        layoutViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(titleArray: [String]) {
        itemWidth = ScreenWidth / CGFloat(titleArray.count)
        if itemWidth <= defaultItemWidth { // item最小宽度为375屏幕宽度的六分之一
            itemWidth = defaultItemWidth
        }
        setupItems(titleArray: titleArray)
    }
    
    //MARK: - 初始化items
    private func setupItems(titleArray: [String]) {
        for (index, item) in titleArray.enumerated() {
            let button = UIButton()
            button.setTitle(item, for: .normal)
            button.backgroundColor = .clear
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = itemFont
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
            scrollView.addSubview(button)
            if index == 0 { // 默认选中第0个
                button.isSelected = true
                selectedItem = button
            }
        }
        setupScrollViewContentSize()
    }
    
    public func updateButtonAttribute(normalColor: UIColor) {
        for view in scrollView.subviews {
            if view.isKind(of: UIButton.self) {
                let button = view as! UIButton
                button.setTitleColor(normalColor, for: .normal)
            }
        }
    }
    
    //MARK: - 设置 scrollView 的 contentSize
    private func setupScrollViewContentSize(){
        let count = CGFloat(titleArray.count)
        scrollView.contentSize = CGSize(width: itemWidth * count + (count - 1) * horizonalSpacing, height: 0)
        updateItems()
    }
    
    //MARK: - 设置约束
    private func layoutViews() {
        scrollView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(itemHeight)
        }
        segmentLine.snp.updateConstraints { (make) in
            make.height.equalTo(segmentLineHeight)
            make.width.equalTo(segmentLineWidth)
            make.centerX.equalTo(itemWidth/2)
            make.top.equalToSuperview().offset(itemHeight - segmentLineHeight)
        }
        bottomLine.snp.updateConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    //MARK: -
    override func layoutSubviews() {
        super.layoutSubviews()
        var index = 0 // 确保index为UIButton所对应
        for item in scrollView.subviews {
            if let button = item as? UIButton {
                button.frame = itemRect.offsetBy(dx: (itemWidth + horizonalSpacing)*CGFloat(index), dy: 0)
                if index == 0{
                    segmentLine.snp.updateConstraints { (make) in
                        make.centerX.equalTo(button.centerX)
                    }
                }
                index += 1
            }
        }
    }
    
    //MARK: -
    private func updateItems(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    //MARK: -
    @objc private func buttonClicked(sender: UIButton) {
        if sender.isSelected == true { return }
        
        updateButtonStatus(sender: sender)
        selectedItemCommand.onNext(getSelectedIndex(sender: sender))
    }
    
    //MARK: - 设置item字体
    private func updateItemsFont(font: UIFont){
        for item in scrollView.subviews {
            if let button = item as? UIButton {
                button.titleLabel?.font = font
            }
        }
    }
    
    //MARK: - 更新按钮选中后的视图状态
    private func updateButtonStatus(sender: UIButton) {
        
        selectedItem?.titleLabel?.font = itemFont
        selectedItem?.isSelected = false
        sender.isSelected = !sender.isSelected
        selectedItem = sender
        
        updateScrollViewOffset(button: sender)
        
        // 更新底部蓝色线条位置
        let lineCenterX = sender.centerX
        segmentLine.snp.updateConstraints { (make) in
            make.centerX.equalTo(lineCenterX)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    //MARK: - 根据点击的位置，更新scrollView偏移量
    private func updateScrollViewOffset(button: UIButton) {
        let scrollViewWidth = scrollView.width
        let scrollViewContentSizeWidth = scrollView.contentSize.width
        var offsetX: CGFloat = 0
        
        if button.centerX < scrollViewWidth/2 {
            offsetX = 0
        } else  if button.centerX + scrollViewWidth/2 < scrollViewContentSizeWidth {
            offsetX = button.centerX - scrollViewWidth/2
        } else {
            offsetX = scrollViewContentSizeWidth - scrollViewWidth
        }
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
    
    //MARK: - 根据选中的位置，获取item
    private func getButton(selectedIndex: Int) -> UIButton? {
        var index = 0 // 确保index为UIButton所对应
        for item in scrollView.subviews {
            if let button = item as? UIButton {
                if selectedIndex == index {
                    return button
                }
                index += 1
            }
        }
        return nil
    }
    
    //MARK: - 根据选中的item获取位置
    private func getSelectedIndex(sender: UIButton) -> Int {
        var index = 0
        for item in scrollView.subviews {
            if let button = item as? UIButton {
                if sender == button {
                    return index
                }
                index += 1
            }
        }
        return 0
    }
    //MARK: - 根据选中的item获取按钮标题
    private func getSelectedTitle(sender: UIButton) -> String? {
        for item in scrollView.subviews {
            if let button = item as? UIButton {
                if sender == button {
                    return sender.titleLabel?.text
                }
            }
        }
        return nil
    }
    
    //MARK: -
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceHorizontal = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = .clear
        self.addSubview(scroll)
        return scroll
    }()
    
    lazy var segmentLine: UIView = {
        let line = UIView()
        line.backgroundColor = color_main_red
        scrollView.addSubview(line)
        return line
    }()
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = color_BgColor
        self.addSubview(line)
        return line
    }()
}
