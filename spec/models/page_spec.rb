require 'spec_helper'

module Spree
  describe Spree::Page, type: :model do
    it "is valid with a title and path" do
      expect(build(:page)).to be_valid
    end

    it "is not valid when title is blank" do
      expect(build(:page, title: '')).to_not be_valid
    end

    it "is not valid when path is already taken" do
      page = create(:page)
      expect(build(:page, path: page.path)).to_not be_valid
    end

    it "aliases title as name" do
      page = create(:page)
      page.name = Faker::Lorem.sentence
      expect(page.name).to eq(page.title)
    end

    context 'setting defaults' do
      it 'sets nav title to title when nav title is blank' do
        page = create(:page, nav_title: "")
        expect(page.nav_title).to eq(page.title)
      end

      it 'does not set nav title to title when nav title is not blank' do
        page = create(:page)
        expect(page.nav_title).to_not eq(page.title)
      end

      it 'will add a leading / to the path if not there' do
        expect(create(:page, path: 'test').path).to eq("/test")
      end

      it 'will not double the leading / of the path' do
        expect(create(:page, path: '/testing').path).to eq("/testing")
      end

      it 'will set a blank path to a parameterized title' do
        page = create(:page, path: '')
        expect(page.path).to eq("/" + page.nav_title.parameterize)
      end
    end

    context "when creating a page" do
      it "will automatically create one piece of content on creation" do
        expect(create(:page).contents.count).to eq(1)
      end

      it "will title the automatically created piece of content the same as the page title" do
        page = create(:page)
        expect(page.contents.first.title).to eq(page.title)
      end
    end

    it "will return title if meta_title is blank" do
      page = create(:page, meta_title: '')
      expect(page.meta_title).to eq(page.title)
    end

    it "will return meta_title if meta_title has a value" do
      page = create(:page)
      expect(page.meta_title).to_not eq(page.title)
    end

    context "when filtering with the ative scope" do
      it "contains posts that are accessible" do
        page = create(:page)
        expect(Spree::Page.active).to include(page)
      end

      it "does not contain posts that are not accessible" do
        page = create(:page, accessible: false)
        expect(Spree::Page.visible).to_not include(page)
      end
    end

    context "when filtering with the visible scope" do
      it "contains posts that are accessible and visible" do
        page = create(:page)
        expect(Spree::Page.visible).to include(page)
      end

      it "does not contain posts that are not accessible" do
        page = create(:page, accessible: false)
        expect(Spree::Page.visible).to_not include(page)
      end

      it "does not contain posts that are not visible" do
        page = create(:page, visible: false)
        expect(Spree::Page.visible).to_not include(page)
      end
    end

    context "root?" do
      it "returns true if the page is a root page" do
        expect(create(:page, path: '/').root?).to eq(true)
      end

      it "returns false if the page is not a root page" do
        expect(create(:page).root?).to_not eq(true)
      end
    end

    context "has_context?" do
      it "returns true if any content has the requested context" do
        page = create(:page)
        content = create(:content, page: page, context: Faker::Lorem.word)
        expect(page.has_context? content.context).to eq(true)
      end

      it "returns false if no content has the requested context" do
        page = create(:page)
        expect(page.has_context? Faker::Lorem.word).to_not eq(true)
      end
    end

    context "for_context" do
      it "returns content that has the requested context" do
        page = create(:page)
        content = create(:content, page: page, context: Faker::Lorem.word)
        expect(page.for_context content.context).to include(content)
      end

      it "returns content that has the requested context" do
        page = create(:page)
        content = create(:content, page: page, context: "test")
        expect(page.for_context "different").to_not include(content)
      end
    end
  end
end
