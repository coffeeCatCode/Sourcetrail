#ifndef NODE_H
#define NODE_H

#include <algorithm>
#include <functional>
#include <map>
#include <string>

#include "data/graph/Edge.h"
#include "data/graph/Token.h"
#include "data/name/NameHierarchy.h"
#include "data/NodeType.h"

class TokenComponentAbstraction;
class TokenComponentAccess;
class TokenComponentConst;
class TokenComponentStatic;
class TokenComponentFilePath;
class TokenComponentSignature;

class Node
	: public Token
{
public:
	Node(Id id, NodeType type, NameHierarchy nameHierarchy, bool defined);
	Node(const Node& other);
	virtual ~Node();

	NodeType getType() const;
	void setType(NodeType type);
	bool isType(NodeType::TypeMask mask) const;

	std::string getName() const;
	std::string getFullName() const;
	NameHierarchy getNameHierarchy() const;

	bool isDefined() const;
	void setDefined(bool defined);

	bool isImplicit() const;
	void setImplicit(bool implicit);

	bool isExplicit() const;
	void setExplicit(bool bExplicit);

	size_t getChildCount() const;
	void setChildCount(size_t childCount);

	size_t getEdgeCount() const;

	void addEdge(Edge* edge);
	void removeEdge(Edge* edge);

	Node* getParentNode() const;
	Node* getLastParentNode();
	Edge* getMemberEdge() const;

	Edge* findEdge(std::function<bool(Edge*)> func) const;
	Edge* findEdgeOfType(Edge::TypeMask mask) const;
	Edge* findEdgeOfType(Edge::TypeMask mask, std::function<bool(Edge*)> func) const;
	Node* findChildNode(std::function<bool(Node*)> func) const;

	void forEachEdge(std::function<void(Edge*)> func) const;
	void forEachEdgeOfType(Edge::TypeMask mask, std::function<void(Edge*)> func) const;
	void forEachChildNode(std::function<void(Node*)> func) const;
	void forEachNodeRecursive(std::function<void(const Node*)> func) const;

	// Token implementation.
	virtual bool isNode() const;
	virtual bool isEdge() const;

	// Component setters.
	void addComponentAbstraction(std::shared_ptr<TokenComponentAbstraction> component);
	void addComponentConst(std::shared_ptr<TokenComponentConst> component);
	void addComponentStatic(std::shared_ptr<TokenComponentStatic> component);
	void addComponentFilePath(std::shared_ptr<TokenComponentFilePath> component);
	void addComponentAccess(std::shared_ptr<TokenComponentAccess> component);

	// Logging.
	virtual std::string getReadableTypeString() const;
	std::string getAsString() const;

private:
	void operator=(const Node&);

	std::map<Id, Edge*> m_edges;

	NodeType m_type;
	NameHierarchy m_nameHierarchy;
	bool m_defined;
	bool m_implicit;
	bool m_explicit;

	size_t m_childCount;
};

std::ostream& operator<<(std::ostream& ostream, const Node& node);

#endif // NODE_H
